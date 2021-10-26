import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  static const routeName = '/history';
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Applications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: Center(child: Text('Applications', style: Theme.of(context).textTheme.headline5,)),
    );
  }
}
