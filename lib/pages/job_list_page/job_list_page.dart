import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/widgets/drawer.dart';

class JobListPage extends StatefulWidget {
  JobListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobListPage> {
  String getAllJobs = """
    query {all_jobs}
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

          List jobs = result.data?['all_jobs'];
          print('jobs: ${jobs}');

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final jobId = jobs[index];
              return JobCard(jobId: jobId);
            },
          );
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String jobId;

  const JobCard({Key? key, required this.jobId}) : super(key: key);

  final String getJobs = """
        query job(\$\_id: ID!) {
        get_jobs(\_id: \$\_id) {
           job_name
            company {
              name
              about
            }
            
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
      }""";

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(getJobs),
          variables: {
            '_id': jobId,
          },
          pollInterval: Duration(seconds: 120),
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Container();
          }
          print('result.data of ${jobId} is ${result.data}');
          var job = result.data?['get_jobs'][0];

          print(job);
          return Container(
            margin: EdgeInsets.all(5),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: Colors.amber,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Text(
                              job['employment_type']['name'].toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Text(
                            job['company']['name'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              job['job_name'].toString(),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            job['address'][0]['address'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Icon(Icons.verified_user),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
