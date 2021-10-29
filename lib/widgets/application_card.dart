import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/MyApplicationBloc/my_application_bloc.dart';

import 'job_type_pill.dart';

class ApplicationCard extends StatelessWidget {
  final dynamic applicationData;

  ApplicationCard({required this.applicationData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Card(
        child: InkWell(
          splashColor: Theme.of(context).focusColor,
          highlightColor: Theme.of(context).highlightColor,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Applied at ${BlocProvider.of<MyApplicationBloc>(context).convertDateTime(applicationData?['applied_at'])}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          // : Text('s'),
                          SizedBox(height: 5),
                          JobTypePill(
                            'Full Time',
                          ),
                          SizedBox(height: 5),
                          Text(
                            applicationData['job']['job_name'],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      foregroundColor: Color.fromRGBO(89, 93, 229, 0.8),
                      radius: 24,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(
                      Icons.info_outlined,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'The job is being reviewed',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.blueGrey,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
