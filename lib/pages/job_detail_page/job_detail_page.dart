import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_events.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/repositories/job_post.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

class JobDetailPage extends StatefulWidget {
  static const routeName = 'job-detail';

  const JobDetailPage({Key? key}) : super(key: key);

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late QueryResult repoJob;
  late GraphQLService service;
  late PostRepository repository;

  @override
  void initState() {
    super.initState();
    service = GraphQLService();
    repository = PostRepository(client: service);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    // repoJob = repository.fetchSingleJob(args['id']);

    buildSkillList(BuildContext context, String title, List skillList) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.bodyText1),
        ...skillList.map(
          (skill) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(skill['name'], style: Theme.of(context).textTheme.bodyText2),
                Row(
                  children: [
                    for (var i = 0; i < skill['level']; i++)
                      Icon(Icons.star, color: Theme.of(context).accentColor),
                  ],
                )
              ],
            );
          },
        )
      ]);
    }

    List<Map> educationLevel = [
      {"name": "Primary", "level": 1},
      {"name": "Secondary", "level": 2},
      {"name": "University", "level": 3},
    ];

    // Stream<String> getJobTitle(String title) async* {
    //   await yield title;
    // }

    return BlocProvider(
      create: (BuildContext context) => DetailBloc(GraphQLService())..add(FetchDetailData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('repoJob'),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(GraphQlQuery.getJob(args['id'])),
          ),
          builder: (QueryResult result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            var job = result.data?['get_jobs'][0];
            print('jobs: ${job}');

            // getJobTitle(job['employment_type']['name']);

            return ListView(
              children: [
                Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Text(job['employment_type']['name']),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Text(job['job_name'],
                                        style: Theme.of(context).textTheme.headline6),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Text(job['company']['name']),
                                  ),
                                  // job['company']['about'].toString().isEmpty
                                  //     ? Text('null')
                                  //     : Text(job['company']['about']),
                                ],
                              ),
                            ),
                            job?['image'] == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      'assets/images/no-job-image.jpeg',
                                      // width: double.infinity,
                                      // width: 100,
                                      height: 100,
                                      // width: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      job['image'],
                                      height: 250,
                                      width: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 5,
                    child: Center(child: Text('Map of Work Address')),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 5,
                    child: Center(child: Text('Time Table')),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // height: 180,
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Education', style: Theme.of(context).textTheme.headline6),
                          SizedBox(height: 10.0),
                          Text(job['education_requirement']['category'],
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 10.0),
                          Divider(),
                          Text('Language', style: Theme.of(context).textTheme.headline6),
                          SizedBox(height: 5.0),
                          buildSkillList(context, 'Spoken Skill', job['spoken_skill']),
                          buildSkillList(context, 'Written Skill', job['written_skill']),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate back to first screen when tapped.
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          onSurface: Colors.red,
                        ),
                        onPressed: () {
                          // Navigate back to first screen when tapped.
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
