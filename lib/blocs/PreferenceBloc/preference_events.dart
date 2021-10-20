import 'package:equatable/equatable.dart';

class PreferenceEvents extends Equatable {
  PreferenceEvents();

  @override
  List<Object> get props => [];
}

class EmptyState extends PreferenceEvents {}
class LoadPreference extends PreferenceEvents {}
