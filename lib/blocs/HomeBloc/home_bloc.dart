import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  late PostRepository jobRepository;

  HomeBloc(this.jobRepository) : super(HomeStates()) {}

  HomeStates get initialState => OnLoading();

  @override
  Stream<HomeStates> mapEventToState(HomeEvents event) async* {
    if (event is FetchHomeData) {
      yield* _mapFetchHomeDataToStates(event);
    }
  }

  Stream<HomeStates> _mapFetchHomeDataToStates(FetchHomeData event) async* {
    try {
      final result = await jobRepository.getJobPosts(10);
      yield LoadDataSuccess(result.data);
    } catch (e) {
      yield LoadDataFail(e.toString());
    }
  }
}
