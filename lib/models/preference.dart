import 'dart:core';

import 'package:hive_flutter/hive_flutter.dart';

part 'preference.g.dart';

@HiveType(typeId: 0)
class Preference extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final DateTime changedDate;
  @HiveField(3)
  bool checked;

  Preference({
    required this.name,
    required this.id,
    required this.changedDate,
    this.checked = false,
  });

  @override
  bool operator ==(other) {
    return (other is Preference) && other.id == id;
  }
}
