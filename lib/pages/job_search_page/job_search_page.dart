import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/widgets/job_card.dart';
import 'package:moovup_demo/pages/job_list_page/job_list_page.dart';
import 'package:moovup_demo/widgets/job_search_form.dart';

class SearchOption {
  String name= '';
  String district= '';
  String time= '';
  String salary= '';
}

class JobSearchPage extends StatefulWidget {
  static const String routeName = 'job-search';
  final String title;
  final String searchCategory;

  JobSearchPage({required this.title, required this.searchCategory});

  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  String getAllJobs = '''
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
  ''';

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Query(
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

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            children: [
              Expanded(child: JobSearchForm()),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 460,
                  child: ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: ListView.builder(
                          itemCount: jobs.length,
                          itemBuilder: (context, index) {
                            final jobId = jobs[index];
                            return JobCard(job: jobId);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

