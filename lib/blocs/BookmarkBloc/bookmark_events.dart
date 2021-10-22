import 'package:equatable/equatable.dart';

abstract class BookmarkEvents extends Equatable {
  BookmarkEvents();

  @override
  List<Object>? get props => null;
}

class FetchBookmarkData extends BookmarkEvents {

  FetchBookmarkData();

  @override
  List<Object>? get props => null;
}


class DeleteBookmark extends BookmarkEvents {
  final String jobId;

  DeleteBookmark(this.jobId);

  @override
  List<Object>? get props => null;
}
