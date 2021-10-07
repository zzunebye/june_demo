import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moovup_demo/providers/preferences.dart';
import 'package:provider/provider.dart';
import './services/GraphQLService.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'config/environment.dart';
import 'models/push_notification.dart';
import 'pages/job_detail_page/job_detail_page.dart';
import 'pages/job_list_page/job_list_page.dart';
import 'pages/preference_page/preference_page.dart';

import 'pages/setting_page/setting_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final _messangerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a onBackground message: ${message.messageId}");
  // Navigator.pushNamed(context, '/preference');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );

  Environment().initConfig(environment);
  final String apiHost = Environment().config.apiHost;

  final GraphQLService gqlService = GraphQLService();
  await gqlService.init(apiHost);

  ValueNotifier<GraphQLClient> client = ValueNotifier(gqlService.client);
  var app = GraphQLProvider(client: client, child: MyApp());
  runApp(app);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;

  void setNotificationInfo(var notification) {
    setState(() {
      _notificationInfo = notification;
      _totalNotifications++;
    });
  }

  void registerNotification(BuildContext context) async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print(
          "Handling a onBackground message: ${message.messageId} title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}");
    });

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("message received");
        print(
            'onMessage title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });

        if (_notificationInfo != null) {
          print("${_notificationInfo!.title}:  ${_notificationInfo!.body!}");

          final snackBar = SnackBar(
            content: Text('Are you interested in ${_notificationInfo!.dataBody!['job_name']}?'),
            action: SnackBarAction(
              label: 'Check!',
              onPressed: () {
                navigatorKey.currentState!.pushNamed(
                  JobDetailPage.routeName,
                  arguments: {
                    'id': _notificationInfo!.dataBody!['id'],
                  },
                );
              },
            ),
          );

          _messangerKey.currentState!.showSnackBar(snackBar);
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  @override
  void initState() {
    _totalNotifications = 0;
    registerNotification(context);
    checkForInitialMessage();

    // For handling notification when the app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data,
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });

      print(
          "Message clicked! Handling a onMessageOpenedApp message: ${message.messageId} title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}");

      navigatorKey.currentState!.pushNamed(
        JobDetailPage.routeName,
        arguments: {
          'id': _notificationInfo!.dataBody!['id'],
          // 'id': job['_id'],
        },
      );
      // navigatorKey.currentState!.pushNamed(JobDetailPage.routeName);
      final snackBar = SnackBar(
        content: Text('You are checking ${_notificationInfo!.dataBody!['job_name']}'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            _messangerKey.currentState!.hideCurrentSnackBar();
          },
        ),
      );

      _messangerKey.currentState!.showSnackBar(snackBar);
    });

    super.initState();
  }

  int _messageCount = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
          JobDetailPage.routeName: (context) => JobDetailPage(),
          JobSearchPage.routeName: (context) =>
              JobSearchPage(title: "Job Searching", searchCategory: ''),
          SettingPage.routeName: (context) => SettingPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
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
