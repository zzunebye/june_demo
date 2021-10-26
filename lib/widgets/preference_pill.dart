import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_bloc.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_events.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_states.dart';
import 'package:moovup_demo/models/preference.dart';

class PreferencePill extends StatelessWidget {
  final int index;
  final Preference pref;

  PreferencePill(this.index, this.pref);

  @override
  Widget build(BuildContext context) {
    PreferenceBloc _bloc = BlocProvider.of<PreferenceBloc>(context);
    return BlocBuilder<PreferenceBloc, PreferenceStates>(
      builder: (BuildContext context, state) {
        if (state is PreferenceLoaded) {
          return Container(
            margin: EdgeInsets.only(right: 6),
            child: ChoiceChip(
              labelStyle: TextStyle(color: Colors.white),
              onSelected: (_) {
                _bloc.add(PillTapped(pref, state.myPrefList));
              },
              selectedColor: Colors.deepPurpleAccent,
              disabledColor: Colors.white,
              label: Text(pref.name),
              selected: state.myPrefList.contains(pref),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(right: 6),
            child: ChoiceChip(
              labelStyle: TextStyle(color: Colors.white),
              onSelected: (_) {},
              selectedColor: Colors.deepPurpleAccent,
              disabledColor: Colors.white,
              label: Text(''),
              selected: false,
            ),
          );
        }
      },
    );
  }
}
