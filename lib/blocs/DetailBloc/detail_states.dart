import 'package:equatable/equatable.dart';

class DetailStates extends Equatable {
  DetailStates();

  @override
  List<Object>? get props => null;
}

class OnLoading extends DetailStates {
  OnLoading() : super();
}

class OnLoadingWithData extends DetailStates {
  final Map<String, dynamic> data;

  OnLoadingWithData(this.data);

  @override
  List<Object> get props => [data];
}

class LoadDataSuccess extends DetailStates {
  final Map<String, dynamic> data;

  LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => [data];
}

class LoadDataFail extends DetailStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
