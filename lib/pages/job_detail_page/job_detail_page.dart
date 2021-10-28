import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_bloc.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_events.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_events.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_states.dart';
import 'package:moovup_demo/pages/apply_job_page/apply_job_page.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:moovup_demo/widgets/appbar_preset.dart';

class JobDetailPage extends StatefulWidget {
  static const routeName = 'job-detail';
  String jobId;

  JobDetailPage(this.jobId);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late DetailBloc _detailBloc;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    print('initState');
    _detailBloc = BlocProvider.of<DetailBloc>(context);
    print('widget id: ${widget.jobId}');
    _detailBloc.add(FetchDetailData(widget.jobId));
    print('initState event added');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSkillList(BuildContext context, String title, List skillList) {
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
                    ...List.generate(skill['level'], (index) => new Icon(Icons.star, color: Theme.of(context).accentColor)),
                  ],
                )
              ],
            );
          },
        )
      ]);
    }

    Widget buildTimeTableRow(int day, var jobDetail) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_detailBloc.convertIntToDate(day), style: Theme.of(context).textTheme.bodyText1),
              Text(_detailBloc.getWorkingHour(jobDetail)),
            ],
          ),
          Divider(height: 10),
        ],
      );
    }

    Widget buildJobDetailView(BuildContext context, var jobDetail) {
      final bool isApplied = jobDetail['is_applied'];
      print("isApplied: $isApplied");
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
                              child: Text(jobDetail['employment_type']['name']),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Text(jobDetail['job_name'], style: Theme.of(context).textTheme.headline6),
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
            child: Card(
              margin: const EdgeInsets.all(10.0),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TimeTable', style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 10),
                    ...jobDetail['working_hour'][0]['day_of_week'].map((day) => buildTimeTableRow(day, jobDetail)).toList(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
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
                    Text(jobDetail['education_requirement']['category'], style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10.0),
                    Divider(),
                    Text('Language', style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 5.0),
                    buildSkillList(context, 'Spoken Skill', jobDetail['spoken_skill']),
                    buildSkillList(context, 'Written Skill', jobDetail['written_skill']),
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
                    onPressed: isApplied ? () => Navigator.of(context).pushNamed(ApplyJobPage.routeName) : null,
                    child: isApplied ? const Text('Apply') : const Text('Applied'),
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
                    _detailBloc..add(SaveJob(jobDetail['is_saved'], jobDetail['_id']));
                  },
                  child: Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        jobDetail['is_saved'] ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
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
    }

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<BookmarkBloc>(context)..add(FetchBookmarkData());
        return true;
      },
      child: Scaffold(
        appBar: AppBarPreset(
          appBartitle: StreamBuilder<String>(
            stream: _detailBloc.jobTitleController.stream,
            initialData: 'Loading...',
            builder: (context, snapshot) {
              return Text('${snapshot.data}');
            },
          ),
        ),
        body: BlocBuilder<DetailBloc, DetailStates>(
          builder: (BuildContext context, DetailStates state) {
            if (state is LoadDataSuccess) {
              var jobDetail = state.data['get_jobs'][0];
              return buildJobDetailView(context, jobDetail);
            } else if (state is LoadDataFail) {
              return Center(
                child: Text(state.error),
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
