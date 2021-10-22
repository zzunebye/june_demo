import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/helpers/enum.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  PostRepository repository = PostRepository(client: GraphQLService());
  StreamController<String> jobTitleController = new StreamController();

  DetailBloc(GraphQLService _graphQLService) : super(OnLoading()) {
    on<SaveJob>(_onSaveJob);
    on<FetchDetailData>(_onFetchDetailData);
  }

  DetailStates get initialState => OnLoading();

  _onSaveJob(SaveJob event, Emitter<DetailStates> emit) async {
    if (this.state is LoadDataSuccess) {
      try {
        final data = (this.state.props as List).first;
        emit(OnLoading());
        await repository.bookmarkJob(event.isSaved ? 'Remove' : 'Add', event.jobId);
        print(data['get_jobs']);
        data['get_jobs'][0]['is_saved'] = !data['get_jobs'][0]['is_saved'];
        emit(LoadDataSuccess(data));
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
      this.jobTitleController.add(result.data!['get_jobs'].first?['job_name']);
      emit(LoadDataSuccess(result.data!));
    } catch (error) {
      emit(LoadDataFail(error));
    }
    jobTitleController.close();
  }

  String convertIntToDate(int day) {
    return weeksName(weekEnum.values[day]);
  }

  String getWorkingHour(dynamic data) {
    return '${data['working_hour'][0]['start_time']} - ${data['working_hour'][0]['end_time']}';
  }
}
