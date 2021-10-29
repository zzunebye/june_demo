class JobApplicationInfo {
  final String jobId;
  final List<String> addressIds;

  JobApplicationInfo(this.jobId, this.addressIds);
}

class ApplicationsInfo {
  final int limit;
  final int offset;
  final String? status;
  final List<String>? applicationIds;

  ApplicationsInfo({this.limit = 30, this.offset = 0, this.status, this.applicationIds});


}
