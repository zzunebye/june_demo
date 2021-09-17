import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/widgets/drawer.dart';
import './widgets/drawer.dart';
import 'pages/job_detail_page/job_detail_page.dart';
import 'pages/job_list_page/job_list_page.dart';
import 'pages/preference_page/preference_page.dart';
import 'package:http/http.dart' as http;

class UserAuth {
  final String bearerToken;

  UserAuth({required this.bearerToken}) {
    // print("bearerToken: "+ bearerToken);
  }
}

void main() async {
  // await initHiveForFlutter();

  var url = Uri.parse('https://api-staging.moovup.hk/v2/create-anonymous');
  var response = await http.post(url, body: {});
  var responseData = json.decode(response.body);
  final HttpLink httpLink = HttpLink(
    'https://api-staging.moovup.hk/v2/seeker',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${responseData['access_token']}',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );

  var app = GraphQLProvider(client: client, child: MyApp());

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Main'),
        '/preference': (context) => PreferencePage(title: 'Preference'),
        '/jobList': (context) => JobListPage(title: 'Job List'),
        '/job-detail': (context) => JobDetailPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
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
      // home: PreferencePage(title: 'Preference'),
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
