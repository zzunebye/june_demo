import 'package:flutter/material.dart';

class PortfolioEditPage extends StatelessWidget {
  static const routeName = '/edit-portfolio';
  const PortfolioEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: Center(child: Text('Edit', style: Theme.of(context).textTheme.headline5,)),
    );
  }
}
