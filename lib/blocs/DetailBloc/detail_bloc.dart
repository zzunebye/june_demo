import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/helpers/enum.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  PostRepository repository = PostRepository(client: GraphQLService());

  DetailBloc(GraphQLService _graphQLService) : super(DetailStates()) {
    on<FetchDetailData>(onFetchDetailData);
  }

  DetailStates get initialState => OnLoading();

  FutureOr<void> onFetchDetailData(FetchDetailData event,
      Emitter<DetailStates> emit) async {
    try {
      final result = await repository.fetchSingleJob(event.jobId);
      emit(LoadDataSuccess(result.data));
    } catch (e) {
      emit(LoadDataFail(e.toString()));
    }
  }

  String convertIntToDate(int day) {
    return weeksName(weekEnum.values[day]);
  }

  String getWorkingHour(dynamic data) {
    return '${data['working_hour'][0]['start_time']} - ${data['working_hour'][0]['end_time']}';
  }

}

