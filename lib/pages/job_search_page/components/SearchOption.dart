import 'package:flutter/material.dart';
import 'package:moovup_demo/widgets/SalaryFilterBottomSheet.dart';

class SearchOptionButton extends StatelessWidget {
  String optionTitle;
  Function buildBar;

  SearchOptionButton({required this.optionTitle, required this.buildBar});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          showModalBottomSheet(
              elevation: 10,
              backgroundColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              context: context,
              builder: (context) {
                if (this.optionTitle == 'Salary') {
                  return SalaryFilterBottomSheet(optionTitle);
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          child: Text(optionTitle,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24)),
                        ),
                        ListTile(
                          leading: new Icon(Icons.share),
                          title: new Text('To be implemented'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(optionTitle, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
