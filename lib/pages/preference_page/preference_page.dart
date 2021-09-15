import 'package:flutter/material.dart';
import 'package:moovup_demo/preference.dart';
import 'package:moovup_demo/widgets/drawer.dart';
import 'package:moovup_demo/widgets/preference_pill.dart';

import 'preference_list.dart';

class PreferencePage extends StatefulWidget {
  PreferencePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  // 이렇게 상태를 선언할 수 있는건가?

  final List<List<Preference>> _theList = [
    [
      Preference(
        id: '1',
        name: 'Full Time',
        checked: true,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '2',
        name: 'Part Time',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '3',
        name: 'Freelance',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '4',
        name: 'Freelance',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ],
    [
      Preference(
        id: '1',
        name: 'Kowloon',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '2',
        name: 'New Territories',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '3',
        name: 'Island',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '4',
        name: 'Others',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ],
    [
      Preference(
        id: '1',
        name: 'Sales',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '2',
        name: 'Serving',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '3',
        name: 'Cosmetics',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '4',
        name: 'Logistics & Transport',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '5',
        name: 'Property Mgt & Security',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '6',
        name: 'Education',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '7',
        name: 'Customer Services',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '8',
        name: 'Maintenance',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '9',
        name: 'Health Services',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '10',
        name: 'Sales / Agents',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '11',
        name: 'Construction',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '12',
        name: 'Cleaning',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ],
    [
      Preference(
        id: '1',
        name: 'English',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '2',
        name: 'Chinese',
        checked: false,
        changedDate: DateTime.now(),
      ),
      Preference(
        id: '3',
        name: 'Lunch Provided',
        checked: false,
        changedDate: DateTime.now(),
      ),
    ]
  ];

  void _onSelectedChip(int section, int index) {
    print('${section}: ${index}');
    setState(() {
      _theList[section][index].checked = !_theList[section][index].checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Preferences",
                style: TextStyle(fontSize: 30),
              ),
            ),
            PreferenceList('Employment Types', _theList[0], _onSelectedChip, 0),
            PreferenceList('Districts', _theList[1], _onSelectedChip, 1),
            PreferenceList('Job Categories', _theList[2], _onSelectedChip, 2),
            PreferenceList('Job Attributes', _theList[3], _onSelectedChip, 3),
            Container(
              // height: size.height * 0.1,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  iconSize: 40,
                  color: Colors.purple,
                  disabledColor: Colors.grey,
                  icon: CircleAvatar(
                    child: Icon(Icons.arrow_right_alt),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
