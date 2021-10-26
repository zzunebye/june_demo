import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_repository.dart';

import 'bookmark_events.dart';
import 'bookmark_states.dart';

class BookmarkBloc extends Bloc<BookmarkEvents, BookmarkStates> {
  late PostRepository jobRepository;

  BookmarkBloc(this.jobRepository) : super(OnLoading()) {
    on<DeleteBookmark>(_onSaveJob);
    on<FetchBookmarkData>(_onFetchBookmarkData);
  }

  // TODO: Make Bookmark item deleteable in Bookmark page
  _onSaveJob(DeleteBookmark event, Emitter<BookmarkStates> emit) async {
    if (this.state is LoadDataSuccess) {
      try {
        emit(LoadDataSuccess(this.state.props));
      } catch (error) {
        // TODO For implementing modal message later
        print(error);
      }
    }
  }

  _onFetchBookmarkData(BookmarkEvents event, Emitter<BookmarkStates> emit) async {
    emit(OnLoading());

    try {
      final result = await jobRepository.getBookmarkJob(20);
      emit(LoadDataSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
  }
}
