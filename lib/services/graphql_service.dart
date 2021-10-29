import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/helpers/graphql_queries.dart';
import 'package:moovup_demo/models/job_application.dart';
import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/services/service.dart';
import 'package:http/http.dart' as http;

class GraphQLService implements IJobService, IUserService {
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

  @override
  getHomepageData() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getHomepage()),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    final result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  @override
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

  @override
  getSingleJobDetail(String id) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getJob()),
      variables: {
        "ids": [id],
      },
      fetchPolicy: FetchPolicy.networkOnly,
    );

    print("options var: ${options.variables.toString()}");

    final result = await _client.query(options);

    print("result in serv: $result");

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  @override
  getBookmarkJob(int limit) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getBookmarks()),
      variables: <String, dynamic>{'limit': limit},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  @override
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

  @override
  searchJobWithOptions(SearchOptionData searchOptionData) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.SearchWithParams()),
      variables: <String, dynamic>{
        "limit": searchOptionData.limit,
        "monthly_rate": searchOptionData.monthly_rate,
        "term": searchOptionData.term,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  @override
  getPortfolio() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getPortfolio()),
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  @override
  applyJob(JobApplicationInfo jobApplication) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQlQuery.applyJob()),
      variables: {
        "address_ids": jobApplication.addressIds,
        "job_id": jobApplication.jobId,
      },
    );

    print("variables: ${options.variables}");

    final QueryResult result = await _client.mutate(options);
    print(result);

    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }

  @override
  getApplications(ApplicationsInfo applicationsInfo) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.getApplications()),
      variables: {
        "limit": applicationsInfo.limit,
        "offset": applicationsInfo.offset,
        "status": applicationsInfo.status,
        "application_ids": applicationsInfo.applicationIds,
      },
    );

    print("variables: ${options.variables}");

    final QueryResult result = await _client.query(options);

    // print("result.data: ${result.data}");

    // print("getApplications QueryResult $result");

    // throw UnimplementedError();
    if (result.hasException) {
      throw result.exception!;
    } else {
      return result;
    }
  }
}
