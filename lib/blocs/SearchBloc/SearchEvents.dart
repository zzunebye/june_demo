import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/search_option_data.dart';

abstract class SearchEvents extends Equatable {
  SearchEvents();

  @override
  List<Object> get props => [];
}

class FetchSearchData extends SearchEvents {
  final SearchOptionData searchOption;

  FetchSearchData(this.searchOption);

  @override
  List<Object> get props => [searchOption];
}

class ResetSearch extends SearchEvents {
  ResetSearch();
}

class UpdateWage extends SearchEvents {
  final List<double> wageRange;

  UpdateWage(this.wageRange);

  @override
  List<Object> get props => [wageRange];
}

class UpdateTerm extends SearchEvents {
  final String term;

  UpdateTerm(this.term);

  @override
  List<Object> get props => [term];
}
