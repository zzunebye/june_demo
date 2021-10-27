import 'package:equatable/equatable.dart';

class ApplyJobStates extends Equatable {
  ApplyJobStates();

  @override
  List<Object>? get props => null;
}

class OnLoading extends ApplyJobStates {
  OnLoading() : super();
}

class LoadDataSuccess extends ApplyJobStates {
  final dynamic data;

  LoadDataSuccess(this.data) : super() {}

  @override
  List<Object> get props => [data];
}

class LoadDataFail extends ApplyJobStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
