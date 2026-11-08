import 'package:flutter/foundation.dart';

class RecentProvider extends ChangeNotifier {
  final List<String> _ids = [];
  static const int maxCount = 10;

  List<String> get ids => _ids;

  void add(String id) {
    _ids.remove(id);
    _ids.insert(0, id);
    if (_ids.length > maxCount) {
      _ids.removeRange(maxCount, _ids.length);
    }
    notifyListeners();
  }

  void clear() {
    _ids.clear();
    notifyListeners();
  }
}
