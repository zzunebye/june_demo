import 'package:flutter/material.dart';
import 'package:moovup_demo/widgets/job_type_pill.dart';
import '../pages/job_detail_page/job_detail_page.dart';

class JobCard extends StatelessWidget {
  final Map job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  void selectJobCard(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => JobDetailPage(job['_id'])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: InkWell(
        onTap: () => selectJobCard(context),
        child: Card(
          // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JobTypePill(job['employment_type']['name'].toString()),
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
      ),
    );
  }
}
