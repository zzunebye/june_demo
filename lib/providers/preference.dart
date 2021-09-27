import 'package:flutter/foundation.dart';

class Preference with ChangeNotifier {
  final String name;
  final String id;
  final DateTime changedDate;
  bool checked;

  Preference({
    required this.name,
    required this.id,
    required this.changedDate,
    this.checked = false,
  });

  void toggleStatus() {
    checked = !checked;
    notifyListeners();
  }
}
