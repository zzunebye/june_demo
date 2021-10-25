abstract class IService {
  getJobPosts(int limit){}

  getSingleJobDetail(String id){}

  getBookmarkJob(String jobId, int limit){}

  bookmarkJob(String action, String jobId){}
}
