import 'package:flutter/foundation.dart';

class Preference {
  final String name;
  final String id;
  bool checked;
  final DateTime changedDate;

  // const Preference({Key? key}) : super(key: key);

  Preference({
    required this.name,
    required this.id,
    required this.checked,
    required this.changedDate,
  });
}
