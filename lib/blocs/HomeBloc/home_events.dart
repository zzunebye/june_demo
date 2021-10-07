import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  HomeEvents();

  @override
  List<Object>? get props => null;
}

class FetchHomeData extends HomeEvents {
  // final String query;
  // late Map<String, dynamic> variables;
  //
  // FetchHomeData({required this.query}) : super();

  FetchHomeData();

  @override
  List<Object>? get props => null;

}