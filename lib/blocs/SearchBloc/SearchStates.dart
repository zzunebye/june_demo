import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/search_option_data.dart';
class SearchStates extends Equatable {
  final SearchOptionData searchOption;

  SearchStates(this.searchOption);

  @override
  List<Object>? get props => [searchOption];
}

class EmptyState extends SearchStates {
  final SearchOptionData searchOption;

  EmptyState(this.searchOption) : super(searchOption);
}

class OnLoading extends SearchStates {
  final SearchOptionData searchOption;

  OnLoading(this.searchOption) : super(searchOption);
}

class LoadDataSuccess extends SearchStates {
  final dynamic data;
  final SearchOptionData searchOption;

  LoadDataSuccess(this.data, this.searchOption) : super(searchOption);

  @override
  List<Object> get props => data;
}

class LoadDataFail extends SearchStates {
  final dynamic error;
  final SearchOptionData searchOption;

  LoadDataFail(this.error, this.searchOption) : super(searchOption);

  @override
  List<Object> get props => error;
}
