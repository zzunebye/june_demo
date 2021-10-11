import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'home_events.dart';
import 'home_states.dart';

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

    try {
      final result = await repository.fetchJobPosts();

      if (result.hasException) {
        //MARK: below code will be testing on GraphQL Query
        // print('graphQLErrors: ${result.exception!.graphqlErrors.toString()}');
        yield LoadDataFail(result.exception!.graphqlErrors[0]);
      } else {
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      //MARK: below code will be testing on GraphQL Query
      // print(e);
      yield LoadDataFail(e.toString());
    }
  }

}

