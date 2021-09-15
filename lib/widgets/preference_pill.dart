import 'package:flutter/material.dart';

class PreferencePill extends StatelessWidget {
  final String pillTitle;
  final int index;
  final int section;
  final bool selected;
  final Function onSelect;

  PreferencePill(this.index, this.section, this.pillTitle, this.selected, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      child: ChoiceChip(
        labelStyle: TextStyle(color: Colors.white),
        onSelected: (elem) {onSelect(section,index);},
        selectedColor: Colors.deepPurpleAccent,
        disabledColor: Colors.white,
        label: Text(pillTitle),
        selected: selected,
      ),
    );
  }
}
