import 'dart:core';

import 'package:flutter/material.dart';

import 'preference.dart';

class Preferences with ChangeNotifier {
  final List<List<Preference>> _prefList = [
    [
      Preference(
        id: 'e1',
        name: 'Full Time',
        checked: true,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'e2',
        name: 'Part Time',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'e3',
        name: 'Freelance',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'e4',
        name: 'Freelance',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ],
    [
      Preference(
        id: 'd1',
        name: 'Kowloon',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'd2',
        name: 'New Territories',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'd3',
        name: 'Island',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'd4',
        name: 'Others',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ],
    [
      Preference(
        id: 'c1',
        name: 'Sales',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c2',
        name: 'Serving',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c3',
        name: 'Cosmetics',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c4',
        name: 'Logistics & Transport',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c5',
        name: 'Property Mgt & Security',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c6',
        name: 'Education',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c7',
        name: 'Customer Services',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c8',
        name: 'Maintenance',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c9',
        name: 'Health Services',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c10',
        name: 'Sales / Agents',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c11',
        name: 'Construction',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'c12',
        name: 'Cleaning',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ],
    [
      Preference(
        id: 'a1',
        name: 'English',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'a2',
        name: 'Chinese',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: 'a3',
        name: 'Lunch Provided',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ]
  ];

  List<List<Preference>> get list {
    return [..._prefList];
  }
}
