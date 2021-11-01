import 'package:flutter/material.dart';
import 'package:moovup_demo/widgets/job_type_pill.dart';

import '../pages/job_detail_page/job_detail_page.dart';

class JobCard extends StatelessWidget {
  final Map job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  void selectJobCard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => JobDetailPage(
          job['_id'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 136,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => selectJobCard(context),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          JobTypePill(job['employment_type']['name'].toString()),
                          SizedBox(height: 2),
                          Text(
                            job['company']['name'].toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 2),
                          Text(
                            job['job_name'].toString(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            job['address'][0]['address'].toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        foregroundColor: Color.fromRGBO(89, 93, 229, 0.8),
                        radius: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Text('\$ 13.5k+/hour', style: Theme.of(context).textTheme.bodyText1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
