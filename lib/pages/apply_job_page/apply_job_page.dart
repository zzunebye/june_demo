import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/DetailBloc/detail_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_states.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    jobData = BlocProvider.of<DetailBloc>(context).state.props as List;
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
          if (state is LoadDataSuccess) {
            print(state.data);
            return ListView(children: [
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
                        Navigator.of(context).pushNamed(ApplyJobResultPage.routeName);
                      },
                      icon: Icon(Icons.check_circle_outline),
                      label: Text('Submit'),
                    ),
                  )
                ],
              ),
            ]);
          } else {
            return Center(child: (Text("Implementation Error")));
          }
        },
      ),
    );
  }
}
