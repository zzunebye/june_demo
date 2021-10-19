import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';

class SearchStates extends Equatable {
  SearchOptionData searchOption;
  SearchStates(this.searchOption);

  @override
  List<Object>? get props => [searchOption];
}

class EmptyState extends SearchStates {
  SearchOptionData searchOption;

  EmptyState(this.searchOption) : super(searchOption);
}

class OnLoading extends SearchStates {
  SearchOptionData searchOption;

  OnLoading(this.searchOption) : super(searchOption);
}

class LoadDataSuccess extends SearchStates {
  final dynamic data;
  SearchOptionData searchOption;

  LoadDataSuccess(this.data, this.searchOption) : super(searchOption) {
  }

  @override
  List<Object> get props => data;
}

class LoadDataFail extends SearchStates {
  final dynamic error;
  SearchOptionData searchOption;

  LoadDataFail(this.error, this.searchOption) : super(searchOption);

  @override
  List<Object> get props => error;
}

