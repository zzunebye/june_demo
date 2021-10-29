import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/HomeBloc/home_bloc.dart';
import 'package:moovup_demo/blocs/HomeBloc/home_states.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../helpers/constants.dart';
import 'category_container.dart';
import 'job_card.dart';

class HomePageContents extends StatelessWidget {
  final List<Object> data;
  final Map homepageData;

  HomePageContents(this.data, this.homepageData);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: CarouselSlider(
              items: (homepageData['home_banners'] as List).map((banner) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                    child: Image.network(
                      banner['cover_image'],
                      fit: BoxFit.fitWidth,
                    ),
                  );
                });
              }).toList(),
              options: CarouselOptions(
                height: 162.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
          ),
          Container(
            height: 230,
            width: double.infinity,
            child: GridView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.all(25),
              children: jobCategories.map((catData) => CategoryButton(catData)).toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(homepageData['job_recommended_list']['name'][0]['value'].toString(), style:,)
              ],
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
