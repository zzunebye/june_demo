import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchStates.dart';
import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  late PostRepository repository;
  late final Box _recentSearchBox;

  Box get recentSearchBox => _recentSearchBox;

  SearchBloc() : super(EmptyState(SearchOptionData.empty())) {
    this.repository = PostRepository(client: GraphQLService());
    this._recentSearchBox = Hive.box('resentSearchBox');
    on<FetchSearchData>(onFetchSearchData);
    on<ResetSearch>(onResetSearch);
    on<UpdateWage>(onUpdateWage);
    on<UpdateTerm>(onUpdateTerm);
  }

  @override
  Future<void> close() async {
    //cancel streams
    _recentSearchBox.close();
    super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> onFetchSearchData(
      FetchSearchData event, Emitter<SearchStates> emit) async {
    try {
      final searchResult =
          await repository.SearchJobWithOptions(this.state.searchOption);
      emit(LoadDataSuccess(searchResult.data, this.state.searchOption));
    } catch (e) {
      emit(LoadDataFail(e.toString(), this.state.searchOption));
    }
  }

  FutureOr<void> onResetSearch(ResetSearch event, Emitter<SearchStates> emit) {
    try {
      emit(EmptyState(SearchOptionData.empty()));
    } catch (e) {
      emit(LoadDataFail(e.toString(), this.state.searchOption));
    }
  }

  FutureOr<void> onUpdateWage(
    UpdateWage event,
    Emitter<SearchStates> emit,
  ) async {
    this.state.searchOption.monthly_rate = event.wageRange;
    emit(OnLoading(this.state.searchOption));
    this.add(FetchSearchData(this.state.searchOption));
  }

  FutureOr<void> onUpdateTerm(
    UpdateTerm event,
    Emitter<SearchStates> emit,
  ) async {
    this.state.searchOption.term = event.term;
    _addSearchHive(event.term);
    emit(OnLoading(this.state.searchOption));
    this.add(FetchSearchData(this.state.searchOption));
  }

  void _addSearchHive(String term) async {
    _recentSearchBox.add(term);
  }

  void deleteSearchHive(int index) async {
    _recentSearchBox.deleteAt(index);
  }
}
