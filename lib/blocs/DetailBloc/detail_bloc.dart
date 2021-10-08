import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/config/environment.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  late GraphQLService service = GraphQLService();
  late PostRepository repository;

  DetailBloc(GraphQLService _graphQLService) : super(DetailStates()) {
    this.service = GraphQLService();
    this.repository = PostRepository(client: service);
  }

  DetailStates get initialState => OnLoading();

  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is FetchDetailData) {
      yield* _mapFetchDetailDataToStates(event);
    }
  }

  Stream<DetailStates> _mapFetchDetailDataToStates(FetchDetailData event) async* {
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

