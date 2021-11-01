// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/pages/job_detail_page/job_detail_page.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:moovup_demo/services/graphql_service.dart';

class MockDetailBloc extends Mock implements DetailBloc {
  MockDetailBloc(MockPostRepository mockPostRepository);
}

class MockGraphQlService extends Mock implements GraphQLService {}

class MockPostRepository extends Mock implements PostRepository {
  MockPostRepository(MockGraphQlService mockGraphQlService);
}

void main() {
  final detailBloc = MockDetailBloc(MockPostRepository(MockGraphQlService()));
  testWidgets('Show JobDetailPage', (WidgetTester tester) async {
    setUp((){
      when(detailBloc..('184817bf-649d-4cc5-8361-f9546bf73d94')).thenAnswer((_) async => {'result': {'data': {}}});
    })

    final jobId = "18747439-23db-4529-abc7-35ec6481cfa9";
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MockDetailBloc>(
          create: (context) => MockDetailBloc(MockPostRepository(MockGraphQlService())),
          child: JobDetailPage(jobId),
        ),
      ),
    );

    await tester.pump(); // force update widget
    //
    expect(find.text('Locations'), findsOneWidget);
    expect(find.text('TimeTable'), findsOneWidget);
    expect(find.text('Education'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
  });
}
