import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchBloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';

class SalaryFilterBottomSheet extends StatefulWidget {
  String title;

  SalaryFilterBottomSheet(this.title);

  @override
  _SalaryFilterBottomSheetState createState() => _SalaryFilterBottomSheetState();
}

class _SalaryFilterBottomSheetState extends State<SalaryFilterBottomSheet> {
  double _minSalary = 0;
  double _maxSalary = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            child: Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 24)),
          ),
          Expanded(
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _maxSalary = 25000;
                      });
                    },
                    child: Text("25K+")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _maxSalary = 45000;
                      });
                    },
                    child: Text("45K+")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _maxSalary = 60000;
                      });
                    },
                    child: Text("60K+")),
              ]),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<SearchBloc>(context).add(UpdateWage([_minSalary, _maxSalary]));
                Navigator.pop(context);
              },
              child: Text("Confirm"))
        ],
      ),
    );
  }
}
