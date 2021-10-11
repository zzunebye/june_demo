import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  late PostRepository repository;

  DetailBloc(GraphQLService _graphQLService) : super(DetailStates()) {
    print('* Creating Detail Bloc');
    this.repository = PostRepository(client: GraphQLService());
  }

  DetailStates get initialState => OnLoading();

  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    print('* Receiving Event');
    if (event is FetchDetailData) {
      yield* _mapFetchDetailDataToStates(event);
    }
  }

  Stream<DetailStates> _mapFetchDetailDataToStates(FetchDetailData event) async* {
    // final query = event.query;
    // final variables = event.variables;

    try {
      // final result = await service.performQuery(GraphQlQuery.getAllJobs(10));
      final result = await repository.fetchSingleJob(event.jobId);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception!.graphqlErrors.toString()}');
        yield LoadDataFail(result.exception!.graphqlErrors[0]);
      } else {
        // print(result);
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFail(e.toString());
    }
  }

}

