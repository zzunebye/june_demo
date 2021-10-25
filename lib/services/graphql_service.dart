import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/services/service.dart';
import 'package:http/http.dart' as http;


class GraphQlService extends IService {
  late GraphQLClient _client;

  init(apiHost) async {
    final Link link = await getToken(apiHost);
    _client = GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  static getToken(String apiHost) async {
    var url = Uri.parse(apiHost + '/create-anonymous');
    var response = await http.post(url, body: {});
    var responseData = json.decode(response.body);

    final HttpLink httpLink = HttpLink(apiHost + '/seeker');

    final AuthLink authLink = AuthLink(
      // getToken: () async => 'Bearer ${responseData['access_token']}',
      getToken: () async =>
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIxYmI3MWVlZC0xZTBmLTRkZjQtYjA4My0wMjYzYzc5OTYxNTciLCJpYXQiOjE2MzQxMTg1ODAsImlzcyI6Im1vb3Z1cCIsInN1YiI6ImIwM2MxYWMzLWRmODQtNDcwMy1hM2NkLWU3NTUwMzk5OGEwZiIsImV4cCI6MTY0MTg5NDU4MCwiYW5vbnltb3VzPyI6ZmFsc2V9.hysOJzEwTlPxpxreA2AS7Dd0J2qA4M6zz3R4f6FBbYs',
    );

    final Link link = authLink.concat(httpLink);

    return link;
  }

  getJobPosts(int limit) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getAllJobs()),
      variables: {
        "limit": limit,
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    final result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  getSingleJobDetail(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getJob()),
      variables: {
        "ids": [id],
      },
      fetchPolicy: FetchPolicy.networkOnly,
    );

    final result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  getBookmarkJob(String action, int limit) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getBookmarks()),
      variables: <String, dynamic>{'action': action, 'limit': limit},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  bookmarkJob(String action, String jobId) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.updateBookmark()),
      variables: <String, dynamic>{
        'action': action,
        'job_id': jobId,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }
}
