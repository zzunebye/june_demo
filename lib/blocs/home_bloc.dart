import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/config/environment.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import './home_events.dart';
import './home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  late GraphQLService service = GraphQLService();
  late PostRepository repository;

  HomeBloc(GraphQLService _graphQLService) : super(HomeStates()) {
    this.service = GraphQLService();
    this.repository = PostRepository(client: service);
  }

  HomeStates get initialState => OnLoading();

  @override
  Stream<HomeStates> mapEventToState(HomeEvents event) async* {
    if (event is FetchHomeData) {
      yield* _mapFetchHomeDataToStates(event);
    }
  }

  Stream<HomeStates> _mapFetchHomeDataToStates(FetchHomeData event) async* {
    // final query = event.query;
    // final variables = event.variables;

    try {
      // final result = await service.performQuery(GraphQlQuery.getAllJobs(10));
      final result = await repository.fetchJobPosts();

      if (result.hasException) {
        print('graphQLErrors: ${result.exception!.graphqlErrors.toString()}');
        yield LoadDataFail(result.exception!.graphqlErrors[0]);
      } else {
        // print(result);
        print("the page is loaded");
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFail(e.toString());
    }
  }

}

