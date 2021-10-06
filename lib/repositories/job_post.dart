import 'package:flutter/foundation.dart';
import 'package:moovup_demo/helpers/api.dart';
import '../services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostRepository {
  final GraphQLService client;

  PostRepository({
    required this.client,
  });

  Future<QueryResult> fetchJobPosts() async {
    final QueryResult results = await client.performQuery(GraphQlQuery.getAllJobs(10));
    if (results.hasException) {
      throw results;
    } else {
      return results;
    }
  }
}
