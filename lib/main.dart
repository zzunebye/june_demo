import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_bloc.dart';
import 'package:moovup_demo/pages/apply_job_page/apply_job_result_page.dart';
import 'package:moovup_demo/pages/history_page/history_page.dart';
import 'package:moovup_demo/pages/portfollio_page/portfolio_page.dart';
import 'package:moovup_demo/pages/saved_job_page/saved_job_page.dart';

import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'package:moovup_demo/repositories/user_repository.dart';
import 'blocs/BookmarkBloc/bookmark_bloc.dart';
import 'blocs/DetailBloc/detail_bloc.dart';
import 'blocs/HomeBloc/home_bloc.dart';
import 'blocs/NotificationBloc/notification_bloc.dart';
import 'blocs/NotificationBloc/notification_states.dart';
import 'blocs/PortfolioBloc/portfolio_events.dart';
import 'blocs/PreferenceBloc/preference_bloc.dart';
import 'blocs/PreferenceBloc/preference_events.dart';
import 'blocs/SearchBloc/SearchBloc.dart';
import 'config/environment.dart';
import 'models/preference.dart';
import 'pages/apply_job_page/apply_job_page.dart';
import 'pages/job_detail_page/job_detail_page.dart';
import 'pages/job_list_page/job_list_page.dart';
import 'pages/portfolio_edit_page/portfolio_edit_page.dart';
import 'pages/preference_page/preference_page.dart';
import 'pages/setting_page/setting_page.dart';
import 'repositories/preference_repository.dart';
import 'services/graphql_service.dart';
import 'services/hive_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final _messangerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationBloc notificationBloc = NotificationBloc();
  await notificationBloc.initialize();

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );

  Environment().initConfig(environment);
  final String apiHost = Environment().config.apiHost;
  final HiveService hiveService = HiveService({"Preference": PreferenceAdapter()});

  final GraphQLService graphqlService = GraphQLService();
  await graphqlService.init(apiHost);

  var app = MultiRepositoryProvider(
    providers: [
      RepositoryProvider<PostRepository>(create: (context) => PostRepository(graphqlService)),
      RepositoryProvider<PrefRepository>(create: (context) => PrefRepository(hiveService)),
      RepositoryProvider<UserRepository>(create: (context) => UserRepository(graphqlService)),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: notificationBloc,
        ),
        BlocProvider<BookmarkBloc>(
          create: (BuildContext context) => BookmarkBloc(RepositoryProvider.of<PostRepository>(context)),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(RepositoryProvider.of<PostRepository>(context)),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(RepositoryProvider.of<PostRepository>(context), Hive.box('resentSearchBox')),
        ),
        BlocProvider<PreferenceBloc>(
          create: (BuildContext context) => PreferenceBloc(RepositoryProvider.of<PrefRepository>(context))..add(LoadPreference()),
          lazy: false,
        ),
        BlocProvider<PortfolioBloc>(
          create: (BuildContext context) => PortfolioBloc(RepositoryProvider.of<UserRepository>(context))..add(FetchPortfolio()),
        ),
        BlocProvider<DetailBloc>(
          create: (BuildContext context) => DetailBloc(RepositoryProvider.of<PostRepository>(context)),
        ),
      ],
      child: MyApp(),
    ),
  );
  runApp(app);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  int _messageCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is JobDetailNotificationState) {
          final snackBar = SnackBar(
            content: state.notificationInfo.getForeground
                ? Text('Are you interested in ${state.notificationInfo.dataBody!['job_name']}?')
                : Text('You are checking ${state.notificationInfo.dataBody!['job_name']}'),
            action: state.notificationInfo.getForeground
                ? SnackBarAction(
                    label: 'Check!',
                    onPressed: () {
                      navigatorKey.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => JobDetailPage(state.notificationInfo.dataBody!['id']),
                        ),
                      );
                    },
                  )
                : SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                      _messangerKey.currentState!.hideCurrentSnackBar();
                    },
                  ),
          );

          _messangerKey.currentState!.showSnackBar(snackBar);
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: _messangerKey,
        routes: {
          '/': (context) => JobListPage(title: 'Main'),
          PreferencePage.routeName: (context) => PreferencePage(title: 'Preference'),
          JobListPage.routeName: (context) => JobListPage(title: 'Job List'),
          JobDetailPage.routeName: (context) => JobDetailPage("jobId"),
          SavedJobPage.routeName: (context) => SavedJobPage(),
          HistoryPage.routeName: (context) => HistoryPage(),
          ApplyJobPage.routeName: (context) => ApplyJobPage(),
          PortfolioPage.routeName: (context) => PortfolioPage(),
          PortfolioEditPage.routeName: (context) => PortfolioEditPage(),
          JobSearchPage.routeName: (context) => JobSearchPage(title: "Job Searching", searchCategory: ''),
          SettingPage.routeName: (context) => SettingPage(),
          ApplyJobResultPage.routeName: (context) => ApplyJobResultPage(),
        },
        theme: ThemeData(
          // primarySwatch: Colors.indigo,
          primaryColor: Color.fromRGBO(89, 93, 229, 1),
          canvasColor: Color.fromRGBO(251, 250, 255, 1),
          buttonColor: Colors.deepOrange,
          highlightColor: Colors.amber,
          accentColor: Colors.amber,
          // errorColor: Colors.red,
          // canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline5: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
