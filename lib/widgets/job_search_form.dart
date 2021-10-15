import 'package:flutter/material.dart';

class JobSearchForm extends StatefulWidget {
  const JobSearchForm({Key? key}) : super(key: key);

  @override
  _JobSearchFormState createState() => _JobSearchFormState();
}

class _JobSearchFormState extends State<JobSearchForm> {
  final _formKey = GlobalKey<FormState>();

  var _districtCategory = ['Kowloon', 'Island', 'New Territories'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                // onSaved: (val) => setState(() => _searchOption.name = val!),
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  labelText: 'Search ...',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
