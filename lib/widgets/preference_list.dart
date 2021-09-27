import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moovup_demo/widgets/preference_pill.dart';

import '../providers/preference.dart';

class PreferenceList extends StatelessWidget {
  final List<Preference> prefList;
  final String title;
  final int section;

  PreferenceList(this.title, this.prefList, this.section);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Text('${title}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          Container(
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 3.0,
                children: List.generate(prefList.length.toInt(), (index) {
                  return ChangeNotifierProvider.value(
                    value: prefList[index],
                    child: PreferencePill(
                      index,
                      section,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
