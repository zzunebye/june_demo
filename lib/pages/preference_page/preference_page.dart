import 'package:flutter/material.dart';
import 'package:moovup_demo/providers/preferences.dart';
import 'package:provider/provider.dart';

import 'package:moovup_demo/providers/preference.dart';
import 'package:moovup_demo/widgets/drawer.dart';
import 'package:moovup_demo/widgets/preference_pill.dart';

import '../../widgets/preference_list.dart';

class PreferencePage extends StatefulWidget {
  static const routeName = '/preference';
  PreferencePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {

  @override
  Widget build(BuildContext context) {
    final prefData = Provider.of<Preferences>(context, listen: false).list;
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
            PreferenceList('Employment Types', prefData[0] , 0),
            PreferenceList('Districts', prefData[1], 1),
            PreferenceList('Job Categories', prefData[2], 2),
            PreferenceList('Job Attributes', prefData[3], 3),
            Container(
              // height: size.height * 0.1,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    setState(() {

                    });
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
