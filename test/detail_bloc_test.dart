import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';

import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_events.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_states.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:moovup_demo/services/graphql_service.dart';

class MockDetailBloc extends MockBloc<DetailEvents, DetailStates> implements DetailBloc {
  MockDetailBloc(MockPostRepository mockPostRepository);
}

class MockPostRepository extends Mock implements PostRepository {
  MockPostRepository() {
    print("MockPostRepository created");
  }
}

class MockGraphQLService extends Mock implements GraphQLService {}

void main() {
  late DetailBloc detailBloc;
  late GraphQLService jobService;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    jobService = MockGraphQLService();
    detailBloc = DetailBloc(mockPostRepository);

    when(
      mockPostRepository.getSingleJobDetail('184817bf-649d-4cc5-8361-f9546bf73d94'),
    ).thenAnswer((_) async => {
          'result': {'data': {}}
        });
  });

  test("initial state should be OnLoading", () async {
    // assert
    expect(detailBloc.state, equals(OnLoading()));
  });

  test(
    'should get detail data from the getDetailData use case',
    () async {
      // arrange
      when(mockPostRepository.getSingleJobDetail('jobId')).thenAnswer((_) async => QueryResult.optimistic());

      // act
      detailBloc.add(FetchDetailData('jobId'));
      await untilCalled(mockPostRepository.getSingleJobDetail('jobId'));

      // assert
      verify(mockPostRepository.getSingleJobDetail('jobId'));
    },
  );

  test(
    'should emit [OnLoading, LoadDataSuccess] when getting data fails',
    () async {
      // arrange
      when(mockPostRepository.getSingleJobDetail('jobId')).thenAnswer((_) async => QueryResult(data: {
            'get_jobs': [{}]
          }, source: QueryResultSource.loading));
      // assert later
      final expected = [
        OnLoading(),
        LoadDataSuccess(
          QueryResult(
            data: {
              'get_jobs': [{}]
            },
            source: QueryResultSource.loading,
          ).data!,
        )
      ];
      expectLater(detailBloc.stream, emitsInOrder(expected));
      // act
      detailBloc.add(FetchDetailData('jobId'));
    },
  );

  tearDown(() {
    detailBloc.close();
  });
}
