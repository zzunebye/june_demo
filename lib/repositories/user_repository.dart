import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/services/service.dart';

class UserRepository {
  final IUserService _dataService;

  UserRepository(this._dataService);

  getPortfolio() {
    try {
      return _dataService.getPortfolio();
    } catch (e) {
      throw e;
    }
  }
}
