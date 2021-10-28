import 'package:flutter/material.dart';
import 'package:moovup_demo/pages/job_list_page/job_list_page.dart';
import 'package:moovup_demo/widgets/appbar_preset.dart';

class ApplyJobResultPage extends StatelessWidget {
  static String routeName = 'apply-job-result';

  const ApplyJobResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPreset(
        appBartitle: Text('Success!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'The job is successfully applied.\nThe employer will soon contact you :)',
                style: TextStyle(fontSize: 18, height: 1.4),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                    child: Text('Go back to Main Page'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    },
                    child: Text('Check the Application Status'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
