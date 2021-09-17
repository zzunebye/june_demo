import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final Map job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(
                          color: Colors.amber,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text(
                        job['employment_type']['name'].toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
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
    );
  }
}
