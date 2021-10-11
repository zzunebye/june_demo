import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_events.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_states.dart';
import 'package:moovup_demo/services/GraphQLService.dart';

class JobDetailPage extends StatefulWidget {
  static const routeName = 'job-detail';
  late String jobId;

  JobDetailPage(this.jobId);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late var jobDetail;
  late DetailBloc _detailBloc;
  bool isSaved = false;

  StreamController<String> streamController = new StreamController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _detailBloc = DetailBloc(GraphQLService());
    _detailBloc..add(FetchDetailData(widget.jobId));
  }

  @override
  Widget build(BuildContext context) {
    buildSkillList(BuildContext context, String title, List skillList) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.bodyText1),
        ...skillList.map(
          (skill) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(skill['name'],
                    style: Theme.of(context).textTheme.bodyText2),
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

    return BlocProvider.value(
      value: _detailBloc,
      child: Scaffold(
        appBar: AppBar(
          title: StreamBuilder<String>(
              stream: streamController.stream,
              initialData: 'Loading...',
              builder: (context, snapshot) {
                return Text('${snapshot.data}');
              }),
        ),
        body: BlocBuilder<DetailBloc, DetailStates>(
          builder: (BuildContext context, DetailStates state) {
            if (state is LoadDataSuccess) {
              jobDetail = state.data['get_jobs'][0];
              streamController.add(jobDetail?['job_name']);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: Text(
                                          jobDetail['employment_type']['name']),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: Text(jobDetail['job_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: Text(jobDetail['company']['name']),
                                    ),
                                  ],
                                ),
                              ),
                              jobDetail?['image'] == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      child: Image.asset(
                                        'assets/images/no-job-image.jpeg',
                                        height: 100,
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
                                        jobDetail['image'],
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
                            Text('Education',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 10.0),
                            Text(jobDetail['education_requirement']['category'],
                                style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(height: 10.0),
                            Divider(),
                            Text('Language',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 5.0),
                            buildSkillList(context, 'Spoken Skill',
                                jobDetail['spoken_skill']),
                            buildSkillList(context, 'Written Skill',
                                jobDetail['written_skill']),
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
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isSaved
                                    ? Icon(Icons.check_box)
                                    : Icon(Icons.check_box_outline_blank),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Save'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
