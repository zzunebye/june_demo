import 'package:equatable/equatable.dart';

class BookmarkStates extends Equatable {
  BookmarkStates();

  @override
  List<Object>? get props => null;
}

class OnLoading extends BookmarkStates {
  OnLoading() : super();
}

class LoadDataSuccess extends BookmarkStates {
  final dynamic data;

  LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => [data];
}

class LoadDataFail extends BookmarkStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}