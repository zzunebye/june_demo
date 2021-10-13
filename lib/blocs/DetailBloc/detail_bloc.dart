import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  late PostRepository repository;

  DetailBloc(GraphQLService _graphQLService) : super(OnLoading()) {
    this.repository = PostRepository(client: GraphQLService());
    on<SaveJob>(_onSaveJob);
    on<FetchDetailData>(_onFetchDetailData);
  }

  DetailStates get initialState => OnLoading();

  _onSaveJob(DetailEvents, Emitter<DetailStates> emit) async {
    final state = this.state;
    print("state: $state");
    // emit(state);
    if (state is LoadDataSuccess) {
      try {
        // NOTE: to be implemented for GQL mutation
        // repository.saveJob(event.jobId);
        // print("try");
        emit(LoadDataSuccess(state.data));
      } catch (error) {
        print(error);
      }
    }
  }

  _onFetchDetailData(DetailEvents, Emitter<DetailStates> emit) async {
    emit(OnLoading());

    try {
      final result = await repository.fetchSingleJob(DetailEvents.jobId);
      emit(LoadDataSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
    print("state: $state");
  }
}
