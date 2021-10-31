import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import 'category_container.dart';
import 'job_card.dart';

class HomePageContents extends StatelessWidget {
  final List<Object> data;
  final Map homepageData;

  HomePageContents(this.data, this.homepageData);

  @override
  Widget build(BuildContext context) {
    print(homepageData['job_featured_lists'][0]['jobs'][0]);
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                      homepageData['job_recommended_list']['name'][0]['value']
                          .toString(),
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: double.infinity,
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        homepageData['job_recommended_list']['jobs'].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final job = (homepageData['job_recommended_list']['jobs']
                          [index] as Map);
                      return JobCard(job: job);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: 1500,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               margin:
          //                   EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //               child: Text(
          //                   homepageData['job_featured_lists'][index]['name'][0]
          //                           ['value']
          //                       .toString(),
          //                   style: Theme.of(context).textTheme.headline6),
          //             ),
          //             Container(
          //               width: double.infinity,
          //               height: 130,
          //               child: ListView.builder(
          //                 scrollDirection: Axis.horizontal,
          //                 itemCount: homepageData['job_featured_lists'][index]
          //                         ['jobs']
          //                     .length,
          //                 shrinkWrap: true,
          //                 itemBuilder: (context, index) {
          //                   final job = (homepageData['job_recommended_list']
          //                       ['jobs'][index] as Map);
          //                   return JobCard(job: job);
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // )
          ...(homepageData['job_featured_lists'] as List).map((jobList) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text(
                        jobList['name'][0]['value']
                            .toString(),
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    width: double.infinity,
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobList['jobs'].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // print(jobList);
                        final job = (jobList['jobs'][index] as Map);
                        // (homepageData['job_featured_lists']['jobs'][index] as Map)
                        return JobCard(job: job);
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
