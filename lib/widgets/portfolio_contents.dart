import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_bloc.dart';
import 'package:moovup_demo/pages/portfolio_edit_page/portfolio_edit_page.dart';
import 'package:provider/provider.dart';

import 'job_type_pill.dart';

class PortfolioContents extends StatefulWidget {
  final Map data;

  PortfolioContents(this.data);

  @override
  _PortfolioContentsState createState() => _PortfolioContentsState();
}

class _PortfolioContentsState extends State<PortfolioContents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PortfolioSection(title: 'Self Introduction', child: buildAbout(widget.data['self_introduction'])),
        PortfolioSection(title: 'Work Experience', child: buildExperiences(widget.data['work_experience'])),
        PortfolioSection(title: 'Education', child: buildEducation(widget.data['education'])),
        PortfolioSection(title: 'Spoken Skill', child: buildLangSkills(widget.data['spoken_skill'])),
        PortfolioSection(title: 'Written Skill', child: buildLangSkills(widget.data['written_skill'])),
        PortfolioSection(title: 'Certificate and License', child: buildSkills(widget.data['cert'])),
        PortfolioSection(title: 'Skill', child: buildSkills(widget.data['skill'])),
      ],
    );
  }

  Widget PortfolioSection({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 18)),
              EditTextButton(title),
            ],
          ),
          child,
        ],
      ),
    );
  }

  Widget buildAbout(String about) {
    return Text(
      about,
      style: TextStyle(fontSize: 15, height: 1.4),
    );
  }

  Widget buildEducation(Map education) {
    return Row(
      children: [
        Text(
          "${education['category']} - ${education['name']}",
          style: TextStyle(fontSize: 15, height: 1.4),
        ),
      ],
    );
  }

  Widget buildCert(List certs) {
    return Column(children: [
      ...certs.map(
        (cert) => Text(cert['name'], style: TextStyle(fontSize: 15)),
      ),
    ]);
  }

  Widget buildLangSkills(List skills) {
    return Column(children: [
      ...skills.map(
        (skill) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skill['name'], style: TextStyle(fontSize: 15)),
            Row(
              children: [
                ...List.generate(skill['level'], (index) => new Icon(Icons.star, color: Theme.of(context).accentColor)),
              ],
            )
          ],
        ),
      ),
    ]);
  }

  Widget buildExperiences(List experiences) {
    return Column(children: [
      ...experiences.map(
        (expr) => Card(
          elevation: 2,
          // color: Colors.amber.shade50,
          color: Theme.of(context).cardColor,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${expr['start_date']} - ${BlocProvider.of<PortfolioBloc>(context).getNowFromNull(expr['end_date'])}",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(expr['position_name'], style: TextStyle(fontSize: 16)),
                    JobTypePill(expr['employment'].toString()),
                  ],
                ),
                SizedBox(height: 3),
                Text(expr['company_name'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                SizedBox(height: 3),
                Text(expr['description'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget buildSkills(List skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...skills.map((skill) => Text(skill['name'], style: TextStyle(fontSize: 15, height: 1.4))),
      ],
    );
  }

  Widget EditTextButton(String title) {
    return TextButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed(PortfolioEditPage.routeName);
        },
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 14,
        ),
        label: Text('Edit', style: TextStyle(fontSize: 14)));
  }
}
