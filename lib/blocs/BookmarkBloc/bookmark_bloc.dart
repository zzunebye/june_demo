import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'bookmark_events.dart';
import 'bookmark_states.dart';

class BookmarkBloc extends Bloc<BookmarkEvents, BookmarkStates> {
  late PostRepository repository;

  BookmarkBloc() : super(OnLoading()) {
    this.repository = PostRepository(client: GraphQLService());
    on<SaveJob>(_onSaveJob);
    on<FetchBookmarkData>(_onFetchDetailData);
  }

  BookmarkStates get initialState => OnLoading();

  _onSaveJob(BookmarkEvents, Emitter<BookmarkStates> emit) async {
    final state = this.state;
    print("state: $state");
    // emit(state);
    if (state is LoadDataSuccess) {
      try {
        // NOTE: to be implemented for GQL mutation
        // repository.saveJob(event.jobId);
        emit(LoadDataSuccess(state.data));
      } catch (error) {
        print(error);
      }
    }
  }

  _onFetchDetailData(BookmarkEvents, Emitter<BookmarkStates> emit) async {
    emit(OnLoading());

    try {
      final result = await repository.fetchSingleJob(BookmarkEvents.jobId);
      emit(LoadDataSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
    print("state: $state");
  }
}
