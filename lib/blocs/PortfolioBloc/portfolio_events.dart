import 'package:equatable/equatable.dart';

abstract class PortfolioEvents extends Equatable {
  PortfolioEvents();

  @override
  List<Object> get props => [];
}

class FetchPortfolio extends PortfolioEvents {
  FetchPortfolio();

  @override
  List<Object> get props => [];
}

class ModifyPortfolio extends PortfolioEvents {
  ModifyPortfolio() : super();
}

class DeletePortfolio extends PortfolioEvents {
  DeletePortfolio();

  @override
  List<Object> get props => [];
}
