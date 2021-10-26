import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_bloc.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_events.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_states.dart';

import 'package:moovup_demo/widgets/drawer.dart';

import '../../widgets/preference_list.dart';

class PreferencePage extends StatefulWidget {
  static const routeName = '/preference';

  PreferencePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  late PreferenceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PreferenceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: BlocBuilder<PreferenceBloc, PreferenceStates>(
          builder: (BuildContext context, state) {
            if (state is PreferenceLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Preferences",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  PreferenceList('Employments', this._bloc.getPrefCategory(state.prefList, 'e'), 0),
                  PreferenceList('Categories', this._bloc.getPrefCategory(state.prefList, 'c'), 0),
                  PreferenceList('Destinations', this._bloc.getPrefCategory(state.prefList, 'd'), 0),
                  PreferenceList('Attributes', this._bloc.getPrefCategory(state.prefList, 'a'), 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              _bloc.savePreference(state.myPrefList);
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
                      ),
                      Container(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              _bloc.add(ResetBtnTapped());
                            },
                            iconSize: 40,
                            color: Colors.red,
                            disabledColor: Colors.grey,
                            icon: CircleAvatar(
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              );
            } else {
              return Text('Wrong');
            }
          },
        ),
      ),
    );
  }
}
