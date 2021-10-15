import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchBloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';

class SalaryFilterBottomSheet extends StatefulWidget {
  String title;

  SalaryFilterBottomSheet(this.title);

  @override
  _SalaryFilterBottomSheetState createState() =>
      _SalaryFilterBottomSheetState();
}

class _SalaryFilterBottomSheetState extends State<SalaryFilterBottomSheet> {
  double minSalary = 0;
  double maxSalary = 99999;

  @override
  Widget build(BuildContext context) {
    final SearchBloc _searchBloc = BlocProvider.of<SearchBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            child: Text(widget.title,
                style: TextStyle(color: Colors.black, fontSize: 24)),
          ),
          Expanded(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            maxSalary = 25000;
                          });
                        },
                        child: Text("25K+")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            maxSalary = 45000;
                          });
                        },
                        child: Text("45K+")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            maxSalary = 60000;
                          });
                        },
                        child: Text("60K+")),
                  ]),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print("SalaryFilterBottomSheet - updateWage: $minSalary, $maxSalary");
                _searchBloc.add(UpdateWage([minSalary, maxSalary]));
                Navigator.pop(context);
              },
              child: Text("Confirm"))
        ],
      ),
    );
  }
}
