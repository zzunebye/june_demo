import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'package:moovup_demo/widgets/category_container.dart';
import 'package:moovup_demo/widgets/drawer.dart';

import '../../dummy_data.dart';
import '../../widgets/job_card.dart';

class JobListPage extends StatefulWidget {
  static const routeName = '/jobList';

  JobListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobListPage> {
  void selectJobCategoryCard(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      JobSearchPage.routeName,
      arguments: {
        'title': 'Job Searching',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.manage_search),
            tooltip: 'Show Search Bar',
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Query(
        options: QueryOptions(
          document: gql(GraphQlQuery.getAllJobs(10)),
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          List jobs = result.data?['job_search']['result'];

          return SingleChildScrollView(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            physics: ScrollPhysics(),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  // flex: 1,
                  height: 230,
                  width: double.infinity,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(25),
                    children: jobCategories
                        .map(
                          (catData) => CategoryButton(catData),
                        )
                        .toList(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      // 전체 context의 크기에 따라서 한 줄에 몇 개의 item이 들어갈지 결정한다.
                      maxCrossAxisExtent: 150, // item 당 차지하는 공간
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 20, // item 사이 간
                      mainAxisSpacing: 20,
                    ),
                  ),
                ),
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
          );
        },
      ),
    );
  }
}
