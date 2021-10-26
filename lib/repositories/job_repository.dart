import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/services/service.dart';

class PostRepository {
  final IJobService _dataService;

  PostRepository(this._dataService);

  getJobPosts(int limit) {
    try {
      return _dataService.getJobPosts(limit);
    } catch (e) {
      throw e;
    }
  }

  getSingleJobDetail(String id) {
    try {
      return _dataService.getSingleJobDetail(id);
    } catch (e) {
      throw e;
    }
  }

  getBookmarkJob(int limit) {
    try {
      return _dataService.getBookmarkJob(limit);
    } catch (e) {
      throw e;
    }
  }

  bookmarkJob(String action, String jobId) {
    try {
      return _dataService.bookmarkJob(action, jobId);
    } catch (e) {
      throw e;
    }
  }

  searchJobWithOptions(SearchOptionData searchOptionData) async {
    try {
      return _dataService.searchJobWithOptions(searchOptionData);
    } catch (e) {
      throw e;
    }
  }
}
