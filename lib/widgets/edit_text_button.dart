import 'package:flutter/material.dart';
import 'package:moovup_demo/pages/portfolio_edit_page/portfolio_edit_page.dart';

class EditTextButton extends StatelessWidget {
  String title;

  EditTextButton(this.title);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed(PortfolioEditPage.routeName);
        },
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 14,
        ),
        label: Text('Edit', style: TextStyle(fontSize: 14)));
  }
}
