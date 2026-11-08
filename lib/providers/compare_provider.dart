import 'package:flutter/foundation.dart';

class CompareProvider extends ChangeNotifier {
  final Set<String> _ids = {};
  static const int maxCount = 3;

  Set<String> get ids => _ids;
  bool has(String id) => _ids.contains(id);

  bool toggle(String id) {
    if (_ids.contains(id)) {
      _ids.remove(id);
      notifyListeners();
      return true;
    }
    if (_ids.length >= maxCount) {
      return false;
    }
    _ids.add(id);
    notifyListeners();
    return true;
  }

  void clear() {
    _ids.clear();
    notifyListeners();
  }
}
