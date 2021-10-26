import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/HomeBloc/home_bloc.dart';
import 'package:moovup_demo/blocs/HomeBloc/home_states.dart';

import '../helpers/constants.dart';
import 'category_container.dart';
import 'job_card.dart';

class JobList extends StatelessWidget {

  final List<Object> data;

  JobList(this.data);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 230,
            width: double.infinity,
            child: GridView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.all(25),
              children: jobCategories
                  .map((catData) => CategoryButton(catData))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final jobId = (data[index] as Map);
              return JobCard(job: jobId);
            },
          ),
        ],
      ),
    );


  }
}
