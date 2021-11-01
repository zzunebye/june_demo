import 'package:equatable/equatable.dart';

abstract class DetailEvents extends Equatable {
  DetailEvents();

  @override
  List<Object> get props => [];
}

class FetchDetailData extends DetailEvents {
  final String jobId;

  FetchDetailData(this.jobId);

  @override
  List<Object> get props => [jobId];
}

class SaveJob extends DetailEvents {
  final bool isSaved;
  final String jobId;

  SaveJob(this.isSaved, this.jobId);

  @override
  List<Object> get props => [isSaved, jobId];
}
