import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/MyApplicationBloc/my_application_bloc.dart';
import 'package:moovup_demo/widgets/application_card.dart';

class HistoryPage extends StatefulWidget {
  static const routeName = '/history';

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  final tabs = ['Waiting', 'Reviewed', 'Rejected'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyApplicationBloc>(context).add(FetchApplications(FetchApplicationsType.ALL));
    _tabController = TabController(vsync: this, length: tabs.length);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            print(0);
            BlocProvider.of<MyApplicationBloc>(context).add(FetchApplications(FetchApplicationsType.ALL));
            break;
          case 1:
            print(1);
            BlocProvider.of<MyApplicationBloc>(context).add(FetchApplications(FetchApplicationsType.REVIEWED));
            break;
          case 2:
            print(2);
            BlocProvider.of<MyApplicationBloc>(context).add(FetchApplications(FetchApplicationsType.REJECTED));
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text('My Applications'),
          backgroundColor: Theme.of(context).canvasColor,
          foregroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            isScrollable: true,
            tabs: [
              for (final tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BlocBuilder<MyApplicationBloc, MyApplicationState>(builder: (context, state) {
              print('Current State is: ${state.runtimeType}');
              if (state is MyApplicationDataSuccess) {
                var applications = state.data['get_applications']['applications'];
                var total = state.data['get_applications']['total'];
                print("total: $total");
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: applications
                              .map((app) {
                                return ApplicationCard(applicationData: app);
                              })
                              .toList()
                              .cast<Widget>(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is MyApplicationOnLoading) {
                return Center(child: LinearProgressIndicator());
              }
              if (state is MyApplicationEmpty) {
                return Center(child: Text("You haven't any job in this list yet."));
              }
              return Center(child: Text('error'));
            }),
            BlocBuilder<MyApplicationBloc, MyApplicationState>(
              builder: (context, state) {
                print('Current State is: ${state.runtimeType}');
                if (state is MyApplicationDataSuccess) {
                  var applications = state.data['get_applications']['applications'];
                  var total = state.data['get_applications']['total'];
                  print("total: $total");
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                              children: applications
                                  .map((app) {
                                    return ApplicationCard(applicationData: app);
                                  })
                                  .toList()
                                  .cast<Widget>())
                        ],
                      ),
                    ),
                  );
                }
                if (state is MyApplicationOnLoading) {
                  return LinearProgressIndicator();
                }
                if (state is MyApplicationEmpty) {
                  return Center(child: Text("You haven't any job in this list yet."));
                }
                return Center(child: Text('error'));
              },
            ),
            BlocBuilder<MyApplicationBloc, MyApplicationState>(
              builder: (context, state) {
                print('Current State is: ${state.runtimeType}');
                if (state is MyApplicationOnLoading) {
                  return LinearProgressIndicator();
                }
                if (state is MyApplicationEmpty) {
                  return Center(child: Text("You haven't any job in this list yet."));
                }
                return Center(child: Text('error'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
