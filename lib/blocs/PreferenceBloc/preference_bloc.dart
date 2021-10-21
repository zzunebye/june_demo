import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_events.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_states.dart';
import 'package:moovup_demo/models/preference.dart';
import 'package:moovup_demo/models/preferences.dart';

class PreferenceBloc extends Bloc<PreferenceEvents, PreferenceStates> {
  late final Box _prefBoxs;

  List<Preference> _prefData = defaultPrefValue;

  late List<Preference> _myPrefData;

  Box get prefBoxs => _prefBoxs;

  List<Preference> get myPrefData => _myPrefData;

  List<Preference> get prefData => _prefData;

  PreferenceBloc() : super(EmptyState()) {
    this._prefBoxs = Hive.box('seekerPrefBox');
    on<LoadPreference>(onLoadPreference);
    on<PillTapped>(onPillTapped);
    on<ResetBtnTapped>(onResetBtnTapped);
  }

  FutureOr<void> onPillTapped(PillTapped event, Emitter<PreferenceStates> emit) {
    emit(PreferenceLoaded(_prefData, togglePreference(List.from(event.prefList), event.pref)));
  }

  FutureOr<void> onResetBtnTapped(ResetBtnTapped event, Emitter<PreferenceStates> emit) {
    emit(PreferenceLoaded(_prefData, []));
  }

  FutureOr<void> onLoadPreference(LoadPreference event, Emitter<PreferenceStates> emit) {
    if (_prefBoxs.isEmpty) _prefBoxs.put('myPref', emptyPrefValue);

    if (!_prefBoxs.containsKey('myPref')) _prefBoxs.put('myPref', emptyPrefValue);

    _myPrefData = this._prefBoxs.get('myPref').cast<Preference>();
    emit(PreferenceLoaded(_prefData, _myPrefData));
  }

  List<Preference> getPrefCategory(List<Preference> prefs, String categoryId) {
    return prefs.where((element) => element.id.toString().startsWith(categoryId)).toList();
  }

  bool isPreferenceSelected(Preference pref) {
    return _myPrefData.contains(pref);
  }

  List<Preference> togglePreference(List<Preference> list, Preference pref) {
    list.contains(pref) ? list.remove(pref) : list.add(pref);
    return list;
  }

  void savePreference(List<Preference> myPrefList) {
    _prefBoxs.put('myPref', myPrefList);
  }
}
