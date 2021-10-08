import 'package:equatable/equatable.dart';

abstract class DetailEvents extends Equatable {
  DetailEvents();

  @override
  List<Object>? get props => null;
}

class FetchDetailData extends DetailEvents {
  // final String query;
  // late Map<String, dynamic> variables;
  //
  // FetchDetailData({required this.query}) : super();

  FetchDetailData();

  @override
  List<Object>? get props => null;

}