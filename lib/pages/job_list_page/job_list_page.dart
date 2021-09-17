import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/widgets/drawer.dart';

import 'job_card.dart';

class JobListPage extends StatefulWidget {
  JobListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobListPage> {
  String getAllJobs = """
    query job {
      job_search (limit: 10){
        total
        result{
          _created_at
              job_name
          company {
            name
            about
          }
          attributes {
            category
            category_display_sequence
          }
          allowances {
            name
            description
          }
          job_types {
            category
            name
            __typename
          }
          to_monthly_rate
          to_hourly_rate
    
          employment
          employment_type {
            name
          }
          state
          attributes {
            category
          }
          address{
            address
            formatted_address
          }
          address_on_map
          images
        }
      }
    }

  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
      body: Query(
        options: QueryOptions(
          document: gql(getAllJobs),
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          List jobs = result.data?['job_search']['result'];
          // print('jobs: ${jobs}');

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final jobId = jobs[index];
              return JobCard(job: jobId);
            },
          );
        },
      ),
    );
  }
}

