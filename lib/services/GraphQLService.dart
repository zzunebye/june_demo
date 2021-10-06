import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

class GraphQLService {
  late GraphQLClient _client;

  static getToken(String apiHost) async {
    var url = Uri.parse(apiHost + '/create-anonymous');
    var response = await http.post(url, body: {});
    var responseData = json.decode(response.body);
    print(responseData);

    final HttpLink httpLink = HttpLink(apiHost + '/seeker');

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${responseData['access_token']}',
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
    _client = await GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  GraphQLClient get client => _client;

  Future<QueryResult> performQuery(String query) async {
    QueryOptions options = QueryOptions(document: gql(query));

    return await _client.query(options);
  }

  Future<QueryResult> performMutation(String query, Map<String, dynamic> variables) async {
    MutationOptions options = MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);

    return result;
  }
}
