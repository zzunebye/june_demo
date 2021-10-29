import 'package:equatable/equatable.dart';

class ApplyJobStates extends Equatable {
  ApplyJobStates();

  @override
  List<Object>? get props => null;
}

class OnLoading extends ApplyJobStates {
  OnLoading() : super();
}

class LoadDataFail extends ApplyJobStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}

class ApplyJobSuccess extends ApplyJobStates {
  final dynamic data;

  ApplyJobSuccess(this.data) : super();

  @override
  List<Object> get props => [data];
}
