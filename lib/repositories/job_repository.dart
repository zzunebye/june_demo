import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/models/search_option_data.dart';
import 'package:moovup_demo/services/service.dart';
import '../services/graphql_service_deprecated.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// deprecated
class JobRepository {
  final GraphQLService client;

  JobRepository({
    required this.client,
  });

  Future<QueryResult> fetchJobPosts() async {
    final QueryResult results = await client.performQuery(GraphQlQuery.getAllJobs(), variable: {
      "limit": 5,
    });

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> fetchSingleJob(String id) async {
    final QueryResult results = await client.performQuery(
      GraphQlQuery.getJob(),
      variable: {
        "ids": [id],
      },
    );

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> fetchBookmarkJob(int limit) async {
    final QueryResult results = await client.performQuery(GraphQlQuery.getBookmarks(), forceNetworkOnly: true);

    if (results.hasException) {
      throw results.exception!;
    } else {
      return results;
    }
  }

  Future<QueryResult> bookmarkJob(String action, String jobId) async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQlQuery.updateBookmark()),
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

  Future<QueryResult> SearchJobWithOptions(SearchOptionData searchOptionData) async {
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

class PostRepository {
  IService _dataService;

  PostRepository(this._dataService);

  getJobPosts(int limit) {
    _dataService.getJobPosts(limit);
  }

  getSingleJobDetail(String id) {
    try {
      final result = _dataService.getSingleJobDetail(id);
      return result;
    } catch (e) {
      throw e;
    }
  }

  getBookmarkJob(jobId, limit) {
    try {
      final result = _dataService.getBookmarkJob(jobId, limit);
      return result;
    } catch (e) {
      throw e;
    }
  }

  bookmarkJob(action, jobId) {
    _dataService.bookmarkJob(action, jobId);
  }
}
