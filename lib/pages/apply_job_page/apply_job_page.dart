import 'package:flutter/material.dart';

class ApplyJobPage extends StatefulWidget {
  const ApplyJobPage({Key? key}) : super(key: key);
  static String routeName = 'applyjob';

  @override
  _ApplyJobPageState createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Center(
          child: Text(
        'Application',
        style: Theme.of(context).textTheme.headline5,
      )),
    );
  }
}
