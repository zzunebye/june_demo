import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'package:moovup_demo/widgets/category_container.dart';
import 'package:moovup_demo/widgets/drawer.dart';

import 'job_card.dart';

const jobCategories = const [
  JobCategory(id: 'j1', title: 'Retail Shop'),
  JobCategory(id: 'j2', title: 'Food & Beverage'),
  JobCategory(id: 'j3', title: 'Events & Promotion'),
  JobCategory(id: 'j4', title: 'Education'),
  JobCategory(id: 'j5', title: 'Office'),
  JobCategory(id: 'j6', title: 'Customer Service'),
  JobCategory(id: 'j7', title: 'Logistics & Transport'),
];

class JobCategory {
  final String id;
  final String title;

  const JobCategory({required this.id, required this.title});
}

class JobListPage extends StatefulWidget {
  JobListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobListPage> {
  String getAllJobs = """
    query job {
      job_search (limit: 10){
        total
        result{
          _id
          _created_at
              job_name
          company {
            name
            about
          }
          attributes {
            category
            category_display_sequence
          }
          allowances {
            name
            description
          }
          job_types {
            category
            name
            __typename
          }
          to_monthly_rate
          to_hourly_rate
    
          employment
          employment_type {
            name
          }
          state
          attributes {
            category
          }
          address{
            address
            formatted_address
          }
          address_on_map
          images
        }
      }
    }
  """;

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
          document: gql(getAllJobs),
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          List jobs = result.data?['job_search']['result'];

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  // flex: 1,
                  height: 230,
                  width: double.infinity,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
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
                Container(
                  width: double.infinity,
                  height: 510,
                  // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final jobId = jobs[index];
                      return JobCard(job: jobId);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
