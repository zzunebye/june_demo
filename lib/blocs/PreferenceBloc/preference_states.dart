import 'package:equatable/equatable.dart';


class PreferenceStates extends Equatable {
  PreferenceStates();

  // TODO: change to the specific type
  dynamic data;

  @override
  List<Object> get props => [];
}

class PreferenceLoading extends PreferenceStates {}

class PreferenceLoaded extends PreferenceStates {}

