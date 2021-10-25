import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'bookmark_events.dart';
import 'bookmark_states.dart';

class BookmarkBloc extends Bloc<BookmarkEvents, BookmarkStates> {
  late PostRepository repository;

  BookmarkBloc() : super(OnLoading()) {
    this.repository = PostRepository(client: GraphQLService());
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
      final result = await repository.fetchBookmarkJob(20);
      emit(LoadDataSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
  }
}
