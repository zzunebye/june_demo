import 'package:flutter/foundation.dart';
import 'package:moovup_demo/helpers/api.dart';
import '../services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostRepository {
  // final GraphQLClient client;
  final GraphQLService client;

  PostRepository({
    required this.client,
  });

  Future<QueryResult> fetchJobPosts() async {
    final results = await client.performQuery(GraphQlQuery.getAllJobs(10));
    print(results);
    return results;
    // if (results.hasException) {
    //   throw results.exception;
    // } else {
    //   return GetPosts$Query.fromJson(results.data).posts;
    // }
  }
}
