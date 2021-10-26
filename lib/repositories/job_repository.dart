import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/services/service.dart';

class PostRepository {
  final IJobService _dataService;

  PostRepository(this._dataService) ;

  getJobPosts(int limit) {
    try {
      final result = _dataService.getJobPosts(limit);

      return result;
    } catch (e) {
      throw e;
    }
  }

  getSingleJobDetail(String id) {
    try {
      final result = _dataService.getSingleJobDetail(id);
      return result;
    } catch (e) {
      throw e;
    }
  }

  getBookmarkJob(int limit) {
    try {
      final result = _dataService.getBookmarkJob(limit);
      return result;
    } catch (e) {
      throw e;
    }
  }

  bookmarkJob(String action, String jobId) {
    try {
      final result = _dataService.bookmarkJob(action, jobId);
      return result;
    } catch (e) {
      throw e;
    }
  }

  searchJobWithOptions(SearchOptionData searchOptionData) async {
    try {
      final result = _dataService.searchJobWithOptions(searchOptionData);
      return result;
    } catch (e) {
      throw e;
    }
  }
}
