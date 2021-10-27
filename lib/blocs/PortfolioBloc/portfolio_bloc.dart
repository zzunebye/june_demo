import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/user_repository.dart';

import 'portfolio_events.dart';
import 'portfolio_states.dart';

class PortfolioBloc extends Bloc<PortfolioEvents, PortfolioStates> {
  late UserRepository userRepository;

  PortfolioBloc(this.userRepository) : super(OnLoading()) {
    on<FetchPortfolio>(_onFetchPortfolio);
  }

  _onFetchPortfolio(PortfolioEvents event, Emitter<PortfolioStates> emit) async {

    emit(OnLoading());

    try {
      final result = await userRepository.getPortfolio();
      emit(LoadDataSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
  }

  String getNowFromNull(String date) {
    return (date != null) ? date : 'Now';
  }
}
