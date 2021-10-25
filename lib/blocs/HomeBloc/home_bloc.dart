import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:moovup_demo/services/graphql_service_deprecated.dart';

import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  late GraphQLService service = GraphQLService();
  late JobRepository repository;

  HomeBloc(GraphQLService _graphQLService) : super(HomeStates()) {
    this.service = GraphQLService();
    this.repository = JobRepository(client: service);
  }

  HomeStates get initialState => OnLoading();

  @override
  Stream<HomeStates> mapEventToState(HomeEvents event) async* {
    if (event is FetchHomeData) {
      yield* _mapFetchHomeDataToStates(event);
    }
  }

  Stream<HomeStates> _mapFetchHomeDataToStates(FetchHomeData event) async* {

    try {
      final result = await repository.fetchJobPosts();
      yield LoadDataSuccess(result.data);
    } catch (e) {
      yield LoadDataFail(e.toString());
    }
  }

}

