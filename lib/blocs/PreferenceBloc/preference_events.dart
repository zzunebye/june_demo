import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/preference.dart';

class PreferenceEvents extends Equatable {
  PreferenceEvents();

  @override
  List<Object> get props => [];
}

class LoadPreference extends PreferenceEvents {}

class ResetBtnTapped extends PreferenceEvents {}

class PillTapped extends PreferenceEvents {
  final List<Preference> prefList;
  final Preference pref;

  PillTapped(this.pref, this.prefList);
}
