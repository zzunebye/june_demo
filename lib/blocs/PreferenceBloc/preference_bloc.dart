import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_events.dart';
import 'package:moovup_demo/blocs/PreferenceBloc/preference_states.dart';

class PreferenceBloc extends Bloc<PreferenceStates, PreferenceEvents> {
  late final Box _prefBoxs;

  PreferenceBloc() : super(EmptyState()) {
    this._prefBoxs = Hive.box('seekerPrefBox');
  }
}