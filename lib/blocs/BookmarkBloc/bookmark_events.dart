import 'package:equatable/equatable.dart';

abstract class BookmarkEvents extends Equatable {
  BookmarkEvents();

  @override
  List<Object>? get props => null;
}

class FetchBookmarkData extends BookmarkEvents {
  // final String jobId;

  FetchBookmarkData();

  @override
  List<Object>? get props => null;
}

class SaveJob extends BookmarkEvents {
  // final String jobId;

  SaveJob();

  @override
  List<Object>? get props => null;
}
