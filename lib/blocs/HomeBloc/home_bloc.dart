import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final PostRepository jobRepository;

  HomeBloc(this.jobRepository) : super(HomeStates()) {
    on<FetchHomeData>(onFetchHomeData);
  }

  HomeStates get initialState => OnLoading();

  FutureOr<void> onFetchHomeData(FetchHomeData event, Emitter<HomeStates> emit) async {
    try {
      final jobPostResult = await jobRepository.getJobPosts(20);
      final homepageResult = await jobRepository.getHomepageData();
      emit(LoadDataSuccess(jobPostResult.data, homepageResult.data));
    } catch (e) {
      emit(LoadDataFail(e.toString()));
    }
  }
}
