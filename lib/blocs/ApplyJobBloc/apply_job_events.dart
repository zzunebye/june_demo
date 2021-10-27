import 'package:equatable/equatable.dart';

abstract class ApplyJobEvents extends Equatable {
  ApplyJobEvents();

  @override
  List<Object>? get props => null;
}

class FetchApplyJob extends ApplyJobEvents {
  FetchApplyJob();

  @override
  List<Object>? get props => null;
}

class ModifyApplyJob extends ApplyJobEvents {
  ModifyApplyJob() : super();
}

class DeleteApplyJob extends ApplyJobEvents {
  DeleteApplyJob();

  @override
  List<Object>? get props => null;
}
