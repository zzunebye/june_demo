import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:http/http.dart' as http;

class BearerToken {
  static getToken() async {
    var url = Uri.parse('https://api-staging.moovup.hk/v2/create-anonymous');
    var response = await http.post(url, body: {});
    var responseData = json.decode(response.body);

    final HttpLink httpLink = HttpLink(
      'https://api-staging.moovup.hk/v2/seeker',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${responseData['access_token']}',
    );

    final Link link = await authLink.concat(httpLink);

    return link;
  }
}


class GraphQLService {
  late GraphQLClient _client;

  GraphQLService() {
  }

   init() async {
     final Link link = await BearerToken.getToken();
    _client = GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  GraphQLClient get client => _client;

  Future<QueryResult> performQuery(String query) async {
    QueryOptions options =
        QueryOptions(document: gql(query));

    final result = await _client.query(options);

    return result;
  }

  Future<QueryResult> performMutation(String query, Map<String, dynamic> variables) async {
    MutationOptions options = MutationOptions(document: gql(query), variables: variables);

    final result = await _client.mutate(options);

    print(result);

    return result;
  }
}
