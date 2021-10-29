part of 'my_application_bloc.dart';

enum FetchApplicationsType {
  ALL,
  REVIEWED,
  REJECTED
}

abstract class MyApplicationEvent extends Equatable {
  const MyApplicationEvent();
}

class FetchApplications extends MyApplicationEvent {
  final FetchApplicationsType applicationType;

  FetchApplications(this.applicationType);


  @override
  List<Object> get props => [applicationType];
}