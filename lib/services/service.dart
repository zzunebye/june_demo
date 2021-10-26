import 'package:moovup_demo/models/search_option_data.dart';

abstract class IService {
  getJobPosts(int limit) async {}

  getSingleJobDetail(String id) async {}

  getBookmarkJob(int limit) async {}

  bookmarkJob(String action, String jobId) async {}

  searchJobWithOptions(SearchOptionData searchOptionData) async {}
}
