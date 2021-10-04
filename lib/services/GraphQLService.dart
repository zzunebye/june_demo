import 'package:graphql/client.dart';

class GraphQLService {
  late GraphQLClient _client;

  GraphQLService() {
    HttpLink link = HttpLink('https://api-staging.moovup.hk/v2/seeker');
    _client = GraphQLClient(link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  Future<QueryResult> performQuery(String query, Map<String, dynamic> variables) async {
    QueryOptions options = QueryOptions(document: gql(query), variables: variables);

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
