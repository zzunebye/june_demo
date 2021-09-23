import 'package:flutter/material.dart';
import 'package:moovup_demo/models/search.dart';

class JobSearchForm extends StatefulWidget {
  const JobSearchForm({Key? key}) : super(key: key);

  @override
  _JobSearchFormState createState() => _JobSearchFormState();
}

class _JobSearchFormState extends State<JobSearchForm> {
  final _formKey = GlobalKey<FormState>();
  SearchOption _searchOption = new SearchOption(
    name: "",
    district: "Kowloon",
    time: "",
    salary: "",
  );

  var _districtCategory = ['Kowloon', 'Island', 'New Territories'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // padding: EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                onSaved: (val) => setState(() => _searchOption.name = val!),
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  labelText: 'Search ...',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            // DropdownButtonFormField(
            //   value: _searchOption.district,
            //   items: _districtCategory.map((item) {
            //     print(item);
            //     return DropdownMenuItem(value: item, child: Text(item));
            //   }).toList(),
            // )
            //   Row(
            //     children: [
            //       // Dropdown
            //       Expanded(
            //         child: DropdownButtonFormField<String>(
            //           onSaved: (val) => _searchOption.district = val!,
            //           value: _searchOption.district,
            //           items: ['Kowloon', 'Island', 'New Territories']
            //               .map<DropdownMenuItem<String>>(
            //             (String val) {
            //               return DropdownMenuItem(
            //                 child: Text(val),
            //                 value: val,
            //               );
            //             },
            //           ).toList(),
            //           onChanged: (val) {
            //             setState(() {
            //               _searchOption.district = val!;
            //             });
            //           },
            //           decoration: InputDecoration(
            //             labelText: 'Expiry Month',
            //             icon: Icon(Icons.calendar_today),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           margin: EdgeInsets.all(0),
            //           // color: Theme.of(context).accentColor,
            //           decoration: BoxDecoration(
            //             color: Theme.of(context).accentColor,
            //             border: Border.all(
            //               color: Theme.of(context).accentColor,
            //               width: 1.0,
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Center(
            //             child: Text('Time'),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           margin: EdgeInsets.all(0),
            //           // color: Theme.of(context).accentColor,
            //           decoration: BoxDecoration(
            //             color: Theme.of(context).accentColor,
            //             border: Border.all(
            //               color: Theme.of(context).accentColor,
            //               width: 1.0,
            //             ),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //
            //           child: Center(
            //             child: Text('Salary'),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
