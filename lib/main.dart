import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moovup_demo/providers/preferences.dart';
import 'package:provider/provider.dart';
import './services/GraphQLService.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';
import 'package:moovup_demo/widgets/drawer.dart';
import './widgets/drawer.dart';
import 'pages/job_detail_page/job_detail_page.dart';
import 'pages/job_list_page/job_list_page.dart';
import 'pages/preference_page/preference_page.dart';
import 'package:http/http.dart' as http;

import 'pages/setting_page/setting_page.dart';

class UserAuth {
  final String bearerToken;

  UserAuth({required this.bearerToken}) {
    // print("bearerToken: "+ bearerToken);
  }
}

void main() async {

  GraphQLService gqlService = GraphQLService();
  await gqlService.init();
  ValueNotifier<GraphQLClient> client = ValueNotifier(
      gqlService.client
  );

  var app = GraphQLProvider(client: client, child: MyApp());

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Preferences(),
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  // Response token;

  Future<http.Response> getBearerToken(String title) {
    return http.post(
      Uri.parse('https://api.moovup.hk/v2/create-anonymous'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Moovup Demo',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    child: Text('Preference'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/preference');
                    },
                  ),
                  ElevatedButton(
                    child: Text('Job List'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/jobList');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
