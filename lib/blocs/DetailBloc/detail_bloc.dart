import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/helpers/enum.dart';
import 'package:moovup_demo/repositories/job_repository.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  final PostRepository jobRepository;
  final jobTitleController = StreamController<String>.broadcast();

  DetailBloc(this.jobRepository) : super(OnLoading()) {
    on<SaveJob>(_onSaveJob);
    on<FetchDetailData>(_onFetchDetailData);
  }

  DetailStates get initialState => OnLoading();

  _onSaveJob(SaveJob event, Emitter<DetailStates> emit) async {
    if (this.state is LoadDataSuccess) {
      try {
        final data = (this.state.props as List).first;
        emit(OnLoading());
        await jobRepository.bookmarkJob(event.isSaved ? 'Remove' : 'Add', event.jobId);
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
      final result = await jobRepository.getSingleJobDetail(event.jobId);
      this.jobTitleController.add(result.data!['get_jobs'].first?['job_name']);
      emit(LoadDataSuccess(result.data!));
    } catch (error) {
      print('error on On..: $error');
      emit(LoadDataFail(error));
    }
  }

  String convertIntToDate(int day) {
    return weeksName(weekEnum.values[day]);
  }

  String getWorkingHour(dynamic data) {
    return '${data['working_hour'][0]['start_time']} - ${data['working_hour'][0]['end_time']}';
  }

  dispose() {
    // jobTitleController.close();
  }
}
