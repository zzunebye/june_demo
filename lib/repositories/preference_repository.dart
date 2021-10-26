import 'package:moovup_demo/models/preference.dart';
import 'package:moovup_demo/services/service.dart';

class PrefRepository {
  final IPrefService _dataService;

  PrefRepository(this._dataService);

  get() {
    try {
      return _dataService.get();
    } catch (e) {
      throw (e);
    }
  }

  store(List<Preference> prefs) {
    try {
      return _dataService.store(prefs);
    } catch (e) {
      throw (e);
    }
  }
}
