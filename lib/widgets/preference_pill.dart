import 'package:flutter/material.dart';
import 'package:moovup_demo/providers/preference.dart';
import 'package:provider/provider.dart';

class PreferencePill extends StatelessWidget {
  final int index;
  final int section;

  PreferencePill(this.index, this.section);

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preference>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(right: 6),
      child: Consumer<Preference>(
          builder: (ctx, product, _) => ChoiceChip(
                labelStyle: TextStyle(color: Colors.white),
                onSelected: (_) {
                  pref.toggleStatus();
                },
                selectedColor: Colors.deepPurpleAccent,
                disabledColor: Colors.white,
                label: Text(pref.name),
                selected: pref.checked,
              )),
    );
  }
}
