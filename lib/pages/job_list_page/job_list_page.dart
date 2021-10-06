import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/blocs/home_bloc.dart';
import 'package:moovup_demo/blocs/home_events.dart';
import 'package:moovup_demo/blocs/home_states.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'package:moovup_demo/services/GraphQLService.dart';
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
  late List<Object> data;

  @override
  void initState() {
    super.initState();
  }

  void selectJobCategoryCard(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      JobSearchPage.routeName,
      arguments: {
        'title': 'Job Searching',
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('GraphQL Demo'),
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => HomeBloc(GraphQLService())..add(FetchHomeData()),
      child: Scaffold(
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
        // body: queryBuild,
        body: JobList(),
      ),
    );
  }
}

class JobList extends StatelessWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        if (state is OnLoading) {
          return LinearProgressIndicator();
        } else if (state is LoadDataFail) {
          return Center(child: Text(state.error));
        } else if (state is LoadDataSuccess) {
          var data = (state).data['job_search']?['result']; //['job_search']['results'];
          return SingleChildScrollView(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            physics: ScrollPhysics(),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
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
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final jobId = (data[index] as Map);
                    // print(jobId);
                    return JobCard(job: jobId);
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("state.error"));
        }
      },
    );
  }
}
