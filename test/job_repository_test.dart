import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:moovup_demo/services/graphql_service.dart';

class MockPostRepository extends Mock implements PostRepository {}

class MockGraphQLService extends Mock implements GraphQLService {}

void main() {
  late MockGraphQLService mockJobService;
  late PostRepository repository;

  setUp(() {
    mockJobService = MockGraphQLService();
    repository = PostRepository(mockJobService);
  });

  final bookmarkResult = {
    "data": {
      "saved_jobs": {
        "total": 1,
        "bookmarks": [
          {
            "_created_at": "2021-11-01T02:57:37Z",
            "job": {
              "_id": "184817bf-649d-4cc5-8361-f9546bf73d94",
              "_created_at": "2021-10-19T04:40:04.223",
              "job_name": "fraud review",
              "start_date": null,
              "end_date": null,
              "address": [
                {"address": "Yuen Long Station, Yuen Long, Hong Kong", "formatted_address": null}
              ],
              "company": {"name": "N/A", "about": "fraud"},
              "job_types": [
                {"category": "Retail Shop", "name": "Cashier"}
              ],
              "to_monthly_rate": 17999.0,
              "to_hourly_rate": null,
              "employment": "FullTime",
              "employment_type": {"name": "Full Time"}
            }
          }
        ]
      }
    }
  };

  test('Getting bookmark data', () async {
    // final service = MockGraphQLService();
    when(mockJobService.getBookmarkJob(1)).thenAnswer((_) async => bookmarkResult);
    // final repository = PostRepository(service);
    // verify(repository.getBookmarkJob(1));

    await expectLater(repository.getBookmarkJob(1), emits((QueryResult result){
      return result.data!.length == bookmarkResult.length;
    }));
  });
}
