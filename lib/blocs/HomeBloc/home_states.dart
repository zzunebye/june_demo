import 'package:equatable/equatable.dart';

 class HomeStates extends Equatable {
  HomeStates();

  @override
  List<Object>? get props => null;
}

class OnLoading extends HomeStates {
  OnLoading() : super();
}

class LoadDataSuccess extends HomeStates {
  final dynamic data;

  LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => [data];
}

class LoadDataFail extends HomeStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}