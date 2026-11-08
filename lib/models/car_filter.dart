enum SortBy { newest, priceLow, priceHigh, mileage }

enum Condition { all, newCar, used }

const _keep = Object();

class CarFilter {
  static const maxPriceLimit = 10000000;

  final Set<String> brands;
  final Set<String> bodyTypes;
  final int minPrice;
  final int maxPrice;
  final Condition condition;
  final String? transmission;
  final String? fuel;
  final SortBy sort;

  const CarFilter({
    this.brands = const {},
    this.bodyTypes = const {},
    this.minPrice = 0,
    this.maxPrice = maxPriceLimit,
    this.condition = Condition.all,
    this.transmission,
    this.fuel,
    this.sort = SortBy.newest,
  });

  int get activeCount =>
      (brands.isNotEmpty ? 1 : 0) +
      (bodyTypes.isNotEmpty ? 1 : 0) +
      (minPrice > 0 || maxPrice < maxPriceLimit ? 1 : 0) +
      (condition != Condition.all ? 1 : 0) +
      (transmission != null ? 1 : 0) +
      (fuel != null ? 1 : 0);

  CarFilter copyWith({
    Set<String>? brands,
    Set<String>? bodyTypes,
    int? minPrice,
    int? maxPrice,
    Condition? condition,
    Object? transmission = _keep,
    Object? fuel = _keep,
    SortBy? sort,
  }) =>
      CarFilter(
        brands: brands ?? this.brands,
        bodyTypes: bodyTypes ?? this.bodyTypes,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        condition: condition ?? this.condition,
        transmission: identical(transmission, _keep)
            ? this.transmission
            : transmission as String?,
        fuel: identical(fuel, _keep) ? this.fuel : fuel as String?,
        sort: sort ?? this.sort,
      );
}
