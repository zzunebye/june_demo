import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/ApplyJobBloc/apply_job_bloc.dart';
import 'package:moovup_demo/blocs/ApplyJobBloc/apply_job_events.dart';
import 'package:moovup_demo/blocs/ApplyJobBloc/apply_job_states.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_states.dart';
import 'package:moovup_demo/models/job_application.dart';
import 'package:moovup_demo/widgets/appbar_preset.dart';
import 'package:moovup_demo/widgets/edit_text_button.dart';
import 'package:moovup_demo/widgets/portfolio_contents.dart';

import 'apply_job_result_page.dart';

class ApplyJobPage extends StatefulWidget {
  const ApplyJobPage({Key? key}) : super(key: key);
  static String routeName = 'apply-job';

  @override
  _ApplyJobPageState createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  late List jobData;
  late String jobId;
  late List<String> addressIds;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      jobData = BlocProvider.of<DetailBloc>(context).state.props as List;
      jobId = jobData[0]['get_jobs'][0]['_id'];
      addressIds = (jobData[0]['get_jobs'][0]['address'] as List).map((address) => address['_id']).toList().cast<String>();
    });
    print(jobData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPreset(
        appBartitle: Text(jobData[0]['get_jobs'][0]['job_name']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: BlocBuilder<PortfolioBloc, PortfolioStates>(
        builder: (context, state) {
          print(state.runtimeType);
          if (state is LoadDataSuccess) {
            print(state.data);
            return BlocListener<ApplyJobBloc, ApplyJobStates>(
              listener: (context, applyJobState) {
                if (applyJobState is ApplyJobSuccess) {
                  Navigator.of(context).pushNamed(ApplyJobResultPage.routeName);
                  return;
                } else {
                  Navigator.of(context).pushNamed(ApplyJobResultPage.routeName);
                  return;
                }
              },
              child: ListView(children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: (state.data['profile_picture'] != null)
                                    ? CircleAvatar(
                                        backgroundColor: Colors.grey.shade800,
                                        radius: 40,
                                        backgroundImage: NetworkImage(state.data['profile_picture']),
                                      )
                                    : CircleAvatar(
                                        radius: 40,
                                        child: FittedBox(
                                          child: Icon(Icons.supervised_user_circle),
                                        ),
                                      ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.data['name'], style: TextStyle(fontSize: 21)),
                                  Text(state.data['telephone'], style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ],
                          ),
                          EditTextButton('NamePh'),
                        ],
                      ),
                    ),
                    PortfolioContents(state.data),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: BLoC to validate form / info
                          BlocProvider.of<ApplyJobBloc>(context).add(ApplyJob(JobApplicationInfo(jobId, addressIds)));
                        },
                        icon: Icon(Icons.check_circle_outline),
                        label: Text('Submit'),
                      ),
                    )
                  ],
                ),
              ]),
            );
          }

          return Center(child: (Text("Implementation Error")));
        },
      ),
    );
  }
}
