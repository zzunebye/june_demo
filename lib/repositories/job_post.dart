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
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> fetchSingleJob(String id) async {
    final QueryResult results = await client.performQuery(GraphQlQuery.getJob(id));

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> fetchBookmarkJob(int limit) async {
    final QueryResult results = await client.performQuery(GraphQlQuery.getBookmarks(limit), forceNetworkOnly: true);

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> bookmarkJob(String action, String jobId) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.updateBookmark(action, jobId)),
      variables: <String, dynamic>{
        'action': action,
        'job_id': jobId,
      },
    );

    final QueryResult results = await client.client.query(options);

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }
}
