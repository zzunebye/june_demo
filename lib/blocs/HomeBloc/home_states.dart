import 'package:equatable/equatable.dart';

class HomeStates extends Equatable {
  HomeStates();

  @override
  List<Object> get props => [];
}

class OnLoading extends HomeStates {
  OnLoading() : super();
}

class LoadDataSuccess extends HomeStates {
  final dynamic jobListData;
  final dynamic homepageData;

  LoadDataSuccess(this.jobListData, this.homepageData);

  @override
  List<Object> get props => [jobListData];
}

class LoadDataFail extends HomeStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
