import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/search.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';

abstract class SearchEvents extends Equatable {
  SearchEvents();

  @override
  List<Object>? get props => null;
}

class FetchSearchData extends SearchEvents {
  final SearchOptionData searchOption;

  FetchSearchData(this.searchOption);

  @override
  List<Object>? get props => [];
}

class ResetSearch extends SearchEvents {
  ResetSearch();
}

class UpdateWage extends SearchEvents {
  final List<double> wageRange;

  UpdateWage(this.wageRange) {
    print("UpdateWage: Event");
  }

  @override
  List<Object>? get props => [];
}
