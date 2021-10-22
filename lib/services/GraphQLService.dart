import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class GraphQLService {
  late GraphQLClient _client;

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

  factory GraphQLService() {
    return _singleton;
  }

  GraphQLService._internal();

  static final GraphQLService _singleton = GraphQLService._internal();

  init(apiHost) async {
    final Link link = await getToken(apiHost);
    _client = GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  GraphQLClient get client => _client;

  Future<QueryResult> performQuery(String query, {variable = const <String, dynamic>{}, forceNetworkOnly = false}) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variable,
      fetchPolicy: forceNetworkOnly ? FetchPolicy.networkOnly : FetchPolicy.cacheAndNetwork,
    );

    return await _client.query(options);
  }

  Future<QueryResult> performQueryWithVars({
    required String query,
    required Map<String, dynamic> variables,
  }) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    return await _client.query(options);
  }

  Future<QueryResult> performMutation(String query, Map<String, dynamic> variables) async {
    MutationOptions options = MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);

    return result;
  }

}
