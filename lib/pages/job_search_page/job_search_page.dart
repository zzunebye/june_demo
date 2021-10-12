import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/widgets/job_card.dart';
import 'package:moovup_demo/models/search.dart';

import 'components/SearchOption.dart';

class searchOptionData {
  static Map district = {'title': 'District'};
  static Map time = {'title': 'Time'};
  static Map salary = {'title': "Title"};
}

class JobSearchPage extends StatefulWidget {
  static const String routeName = 'job-search';
  final String title;
  final String searchCategory;

  JobSearchPage({required this.title, required this.searchCategory});

  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final _formKey = GlobalKey<FormState>();

  SearchOption _searchOption = new SearchOption(
    name: "",
    district: "Kowloon",
    time: "",
    salary: "",
  );

  Future<dynamic> buildModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Query(
      options: QueryOptions(
        document: gql(GraphQlQuery.getAllJobs(20)),
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        List jobs = result.data?['job_search']['result'];

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                // JobSearchForm(),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    // onSaved: (val) => setState(() => _searchOption.name = val!),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      labelText: 'Search ...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchOptionButton(
                            optionTitle: 'District',
                            buildBar: buildModalBottomSheet),
                        SizedBox(width: 10),
                        SearchOptionButton(
                            optionTitle: 'Time',
                            buildBar: buildModalBottomSheet),
                        SizedBox(width: 10),
                        SearchOptionButton(
                            optionTitle: 'Salary',
                            buildBar: buildModalBottomSheet),
                      ],
                    )),
                ListView.builder(
                  itemCount: jobs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final jobId = jobs[index];
                    return JobCard(job: jobId);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
