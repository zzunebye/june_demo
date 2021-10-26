import 'package:flutter/material.dart';
import 'package:moovup_demo/models/job_category.dart';
import 'package:moovup_demo/pages/job_list_page/job_list_page.dart';
import 'package:moovup_demo/pages/job_search_page/job_search_page.dart';

class CategoryButton extends StatelessWidget {
  JobCategory catData;

  CategoryButton(this.catData);

  void selectJobCategory(BuildContext context) {
    // NOTE: print for implmentation
    // print("catData: ${this.catData}");
    Navigator.of(context).pushNamed(
      JobSearchPage.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      onTap: () => selectJobCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.7),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent,
              blurRadius: 0,
              offset: Offset(3, 4),
            ),
          ],
        ),
        child: Container(
          child: Text(
            catData.title,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}
