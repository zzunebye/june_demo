import 'package:equatable/equatable.dart';

class PortfolioStates extends Equatable {
  PortfolioStates();

  @override
  List<Object> get props => [];
}

class OnLoading extends PortfolioStates {
  OnLoading() : super();
}

class LoadDataSuccess extends PortfolioStates {
  final dynamic data;

  LoadDataSuccess(this.data) : super() {
  }

  @override
  List<Object> get props => [data];
}



class LoadDataFail extends PortfolioStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
