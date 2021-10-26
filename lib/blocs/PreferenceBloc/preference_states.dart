import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/preference.dart';

class PreferenceStates extends Equatable {
  PreferenceStates();

  @override
  List<Object> get props => [];
}

// NOTE: When the bloc is created, EmptyState is passed to the bloc constructor.
class EmptyState extends PreferenceStates {
  EmptyState() : super();
}
class PreferenceLoading extends PreferenceStates {}

class PreferenceLoaded extends PreferenceStates {
  final List<Preference> _prefList;
  final List<Preference> _myPrefList;

  PreferenceLoaded(this._prefList, this._myPrefList);

  List<Preference> get prefList => _prefList;

  List<Preference> get myPrefList => _myPrefList;

  @override
  List<Object> get props => [myPrefList];

  bool isPreferenceSelected(Preference pref) {
    return myPrefList.contains(pref);
  }
}


