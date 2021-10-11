import 'package:equatable/equatable.dart';

 class DetailStates extends Equatable {
  DetailStates();

  @override
  List<Object>? get props => null;
}

class OnLoading extends DetailStates {
  OnLoading() : super();
}

class LoadDataSuccess extends DetailStates {
  final dynamic data;

  LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class LoadDataFail extends DetailStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}