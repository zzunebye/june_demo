import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

import 'detail_events.dart';
import 'detail_states.dart';

class DetailBloc extends Bloc<DetailEvents, DetailStates> {
  late PostRepository repository;

  DetailBloc(GraphQLService _graphQLService) : super(DetailStates()) {
    this.repository = PostRepository(client: GraphQLService());
  }

  DetailStates get initialState => OnLoading();

  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is FetchDetailData) {
      yield* _mapFetchDetailDataToStates(event);
    }
  }

  Stream<DetailStates> _mapFetchDetailDataToStates(FetchDetailData event) async* {

    try {
      final result = await repository.fetchSingleJob(event.jobId);

      if (result.hasException) {
        // MARK: below code will be testing on GraphQL Query
        // print('graphQLErrors: ${result.exception!.graphqlErrors.toString()}');
        yield LoadDataFail(result.exception!.graphqlErrors[0]);
      } else {
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      yield LoadDataFail(e.toString());
    }
  }

}

