import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/job_application.dart';

abstract class ApplyJobEvents extends Equatable {
  ApplyJobEvents();

  @override
  List<Object> get props => [];
}

class FetchApplyJob extends ApplyJobEvents {
  FetchApplyJob();

  @override
  List<Object> get props => [];
}

class ApplyJob extends ApplyJobEvents {
  final JobApplicationInfo jobApplication;

  ApplyJob(this.jobApplication);

  @override
  List<Object> get props => [jobApplication];
}

class ModifyApplyJob extends ApplyJobEvents {
  ModifyApplyJob() : super();
}

class DeleteApplyJob extends ApplyJobEvents {
  DeleteApplyJob();

  @override
  List<Object> get props => [];
}
