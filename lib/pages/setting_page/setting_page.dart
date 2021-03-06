import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting';
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: Center(child: Text('Settings', style: Theme.of(context).textTheme.headline5,)),
    );
  }
}
