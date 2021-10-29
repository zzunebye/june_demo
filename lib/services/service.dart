import 'package:moovup_demo/models/job_application.dart';
import 'package:moovup_demo/models/preference.dart';
import 'package:moovup_demo/models/search_option_data.dart';

abstract class IJobService {
  getJobPosts(int limit) async {}

  getSingleJobDetail(String id) async {}

  getBookmarkJob(int limit) async {}

  getHomepageData() async {}

  bookmarkJob(String action, String jobId) async {}

  searchJobWithOptions(SearchOptionData searchOptionData) async {}

  applyJob(JobApplicationInfo jobApplication) async {}

  getApplications(ApplicationsInfo applicationsInfo) async {}
}

abstract class IUserService {
  // getProfile(int limit) async {}

  getPortfolio() async {}

}

abstract class IPrefService {
  store(List<Preference> prefs) {}
  get() {}
}
