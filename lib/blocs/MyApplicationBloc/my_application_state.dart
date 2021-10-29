part of 'my_application_bloc.dart';

abstract class MyApplicationState extends Equatable {
  const MyApplicationState();
}

class MyApplicationInitial extends MyApplicationState {
  @override
  List<Object> get props => [];
}

class MyApplicationOnLoading extends MyApplicationState {
  @override
  List<Object> get props => [];
}

class MyApplicationEmpty extends MyApplicationState {
  @override
  List<Object> get props => [];
}

class MyApplicationDataSuccess extends MyApplicationState {
  final dynamic data;

  MyApplicationDataSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class MyApplicationDataFail extends MyApplicationState {
  final dynamic error;

  MyApplicationDataFail(this.error);

  @override
  List<Object> get props => [error];
}
