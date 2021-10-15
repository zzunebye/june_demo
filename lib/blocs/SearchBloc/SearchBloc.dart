import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchStates.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  late PostRepository repository;

  // NOTE: initial state of the bloc is EmptyState
  SearchBloc() : super(EmptyState(SearchOptionData.empty())) {
    this.repository = PostRepository(client: GraphQLService());
    on<FetchSearchData>(onFetchSearchData);
    on<ResetSearch>(onResetSearch);
    on<UpdateWage>(onUpdateWage);
  }


  // SearchStates get initialState => EmptyState();

  // @override
  // void onChange(Change<int> change) {
  //   super.onChange(change);
  //   print(change);
  // }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> onFetchSearchData(
      FetchSearchData event, Emitter<SearchStates> emit) async {
    print('onFetchSearchData');
    try {
      final searchResult = await repository.SearchJobWithOptions();
      print("searchResult = ${searchResult}");
      emit(EmptyState(this.state.searchOption));
    } catch (e) {
      emit(LoadDataFail(e.toString(), this.state.searchOption));
    }
  }

  FutureOr<void> onResetSearch(ResetSearch event, Emitter<SearchStates> emit) {
    print('onResetSearch');
    emit(EmptyState(this.state.searchOption));
  }

  FutureOr<void> onUpdateWage(UpdateWage event, Emitter<SearchStates> emit) async {
    print('SearchBloc: onUpdateWage, ${event.wageRange}');
    this.state.searchOption.monthly_rate = event.wageRange;
    // var newOptions = this.state.searchOption.props;
    // this.state.searchOption.clone();
    // print();
    print('SearchBloc: emitting.., ${event.wageRange}');
    emit(EmptyState(this.state.searchOption));
    try {
      final result = await repository.SearchJobWithOptions();
      emit(LoadDataSuccess(result.data, this.state.searchOption));
    } catch (e) {
      emit(LoadDataFail(e.toString(), this.state.searchOption));
    }
  }
}
