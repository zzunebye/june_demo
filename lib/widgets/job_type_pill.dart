import 'package:flutter/material.dart';

class JobTypePill extends StatelessWidget {
  final String content;

  JobTypePill(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(
          color: Colors.amber,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Text(
        content,
        style: TextStyle(fontSize: 10, color: Colors.black87),
      ),
    );
  }
}
