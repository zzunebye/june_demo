import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moovup_demo/providers/preferences.dart';
import 'package:provider/provider.dart';
import './services/GraphQLService.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'blocs/NotificationBloc/notification_bloc.dart';
import 'blocs/NotificationBloc/notification_states.dart';
import 'blocs/PreferenceBloc/preference_bloc.dart';
import 'blocs/SearchBloc/SearchBloc.dart';
import 'config/environment.dart';
import 'pages/job_detail_page/job_detail_page.dart';
import 'pages/job_list_page/job_list_page.dart';
import 'pages/preference_page/preference_page.dart';

import 'pages/setting_page/setting_page.dart';

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

  await Hive.initFlutter();

  Environment().initConfig(environment);
  final String apiHost = Environment().config.apiHost;

  final GraphQLService gqlService = GraphQLService();
  await gqlService.init(apiHost);

  ValueNotifier<GraphQLClient> client = ValueNotifier(gqlService.client);

  await Hive.openBox('resentSearchBox');

  var app = MultiBlocProvider(
    providers: [
      BlocProvider.value(value: notificationBloc),
      BlocProvider<SearchBloc>(
        create: (BuildContext context) => SearchBloc(),
      ),
      BlocProvider<PreferenceBloc>(
        create: (BuildContext context) => PreferenceBloc(),
      )
    ],
    child: GraphQLProvider(client: client, child: MyApp()),
  );
  // runApp(app);

  runApp(app);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {}

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
      child: ChangeNotifierProvider(
        create: (ctx) => Preferences(),
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
            JobSearchPage.routeName: (context) => JobSearchPage(title: "Job Searching", searchCategory: ''),
            SettingPage.routeName: (context) => SettingPage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.amber,
            errorColor: Colors.red,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
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
      ),
    );
  }
}
