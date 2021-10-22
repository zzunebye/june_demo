import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  late PostRepository repository;
  StreamController<String> jobTitleController = new StreamController();


  DetailBloc(GraphQLService _graphQLService) : super(OnLoading()) {
    this.repository = PostRepository(client: GraphQLService());
    on<SaveJob>(_onSaveJob);
    on<FetchDetailData>(_onFetchDetailData);
  }

  DetailStates get initialState => OnLoading();

  _onSaveJob(SaveJob event, Emitter<DetailStates> emit) async {
    if (this.state is LoadDataSuccess) {
      try {
        final prevData = (this.state.props as List).single;
        emit(OnLoading());
        await repository.bookmarkJob(event.isSaved ? 'Remove' : 'Add', event.jobId);
        prevData['get_jobs'][0]['is_saved'] = !prevData['get_jobs'][0]['is_saved'];
        emit(LoadDataSuccess(List.from([prevData]).single));
      } catch (error) {
        // TODO For implementing modal message later
        print(error);
      }
    }
  }

  _onFetchDetailData(FetchDetailData event, Emitter<DetailStates> emit) async {
    emit(OnLoading());
    try {
      final result = await repository.fetchSingleJob(event.jobId);
      this.jobTitleController.add(result.data!['get_jobs'].single?['job_name']);
      emit(LoadDataSuccess(result.data!));
    } catch (error) {
      emit(LoadDataFail(error));
    }
    jobTitleController.close();
  }
}
