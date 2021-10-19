import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/models/search_option_data.dart';
import '../services/GraphQLService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostRepository {
  final GraphQLService client;

  PostRepository({
    required this.client,
  });

  Future<QueryResult> fetchJobPosts() async {
    final QueryResult results =
        await client.performQuery(GraphQlQuery.getAllJobs(10));

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> fetchSingleJob(String id) async {
    final QueryResult results =
        await client.performQuery(GraphQlQuery.getJob(id));

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> SearchJobWithOptions(
      SearchOptionData searchOptionData) async {
    final QueryResult results = await client.performQueryWithVars(
      query: GraphQlQuery.SearchWithParams(),
      variables: {
        "limit": searchOptionData.limit,
        "monthly_rate": searchOptionData.monthly_rate,
        "term": searchOptionData.term,
      },
    );

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }
}
