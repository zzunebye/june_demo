import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/models/preference.dart';
import 'package:moovup_demo/models/preferences.dart';
import 'package:moovup_demo/services/service.dart';

class HiveService implements IPrefService {
  HiveService(Map<dynamic, TypeAdapter> typeAdaptors) {
    this.init(typeAdaptors);
  }

  init(Map<dynamic, TypeAdapter> typeAdaptors) async {
    await Hive.initFlutter();

    Hive.registerAdapter<Preference>(PreferenceAdapter());

    await Hive.openBox('resentSearchBox');
    await Hive.openBox('seekerPrefBox');
  }

  get() {
    try {
      final _prefBox = Hive.box('seekerPrefBox');

      if (_prefBox.isEmpty || !_prefBox.containsKey('myPref')) return _prefBox.put('myPref', emptyPrefValue);

      return _prefBox.get('myPref').cast<Preference>();
    } catch (e) {
      throw (e);
    }
  }

  @override
  store(List<Preference> prefs) {
    final _prefBox = Hive.box('seekerPrefBox');

    try {
      _prefBox.put('myPref', prefs);
    } catch (e) {
      throw (e);
    }
  }
}
