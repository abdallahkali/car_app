import 'package:flutter/foundation.dart';
import '../data/car_repository.dart';
import '../models/car.dart';
import '../models/car_filter.dart';

class CarsProvider extends ChangeNotifier {
  CarsProvider(this._repo);
  final CarRepository _repo;

  List<Car> _all = [];
  bool loading = false;
  String? error;
  String query = '';
  CarFilter filter = const CarFilter();

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      _all = await _repo.getCars();
    } catch (_) {
      error = 'تعذّر تحميل السيارات. تأكد من الاتصال وحاول مرة أخرى.';
    }
    loading = false;
    notifyListeners();
  }

  Future<void> addCar(Car car) async {
    final saved = await _repo.addCar(car);
    _all = [saved, ..._all];
    notifyListeners();
  }

  List<Car> get all => _all;
  List<Car> get featured => _all.where((c) => c.featured).toList();
  List<String> get brands => (_all.map((c) => c.brand).toSet().toList()..sort());
  List<String> get bodyTypes =>
      (_all.map((c) => c.bodyType).toSet().toList()..sort());
  List<String> get fuels => (_all.map((c) => c.fuel).toSet().toList()..sort());

  void setQuery(String q) {
    query = q;
    notifyListeners();
  }

  void setFilter(CarFilter f) {
    filter = f;
    notifyListeners();
  }

  void toggleBrand(String brand) {
    final b = {...filter.brands};
    b.contains(brand) ? b.remove(brand) : b.add(brand);
    filter = filter.copyWith(brands: b);
    notifyListeners();
  }

  void reset() {
    filter = const CarFilter();
    query = '';
    notifyListeners();
  }

  List<Car> get results {
    final q = query.trim().toLowerCase();
    final f = filter;
    final list = _all.where((c) {
      if (q.isNotEmpty &&
          !'${c.brand} ${c.name} ${c.year}'.toLowerCase().contains(q)) {
        return false;
      }
      if (f.brands.isNotEmpty && !f.brands.contains(c.brand)) return false;
      if (f.bodyTypes.isNotEmpty && !f.bodyTypes.contains(c.bodyType)) {
        return false;
      }
      if (c.price < f.minPrice || c.price > f.maxPrice) return false;
      if (f.condition == Condition.newCar && !c.isNew) return false;
      if (f.condition == Condition.used && c.isNew) return false;
      if (f.transmission != null && c.transmission != f.transmission) {
        return false;
      }
      if (f.fuel != null && c.fuel != f.fuel) return false;
      return true;
    }).toList();

    switch (f.sort) {
      case SortBy.newest:
        list.sort((a, b) => b.year.compareTo(a.year));
      case SortBy.priceLow:
        list.sort((a, b) => a.price.compareTo(b.price));
      case SortBy.priceHigh:
        list.sort((a, b) => b.price.compareTo(a.price));
      case SortBy.mileage:
        list.sort((a, b) => a.mileage.compareTo(b.mileage));
    }
    return list;
  }
}
