import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_events.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_states.dart';
import 'package:moovup_demo/widgets/job_type_pill.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);
  static String routeName = 'portfolio';

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late PortfolioBloc _bloc;
  final double coverHeight = 180;
  final double profileHeight = 120;

  @override
  void initState() {
    BlocProvider.of<PortfolioBloc>(context).add(FetchPortfolio());
    _bloc = BlocProvider.of<PortfolioBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: BlocBuilder<PortfolioBloc, PortfolioStates>(
        builder: (BuildContext context, PortfolioStates state) {
          if (state is OnLoading) {
            return LinearProgressIndicator();
          } else if (state is LoadDataFail) {
            return Center(child: Text(state.error));
          } else if (state is LoadDataSuccess) {
            var data = (state).data['portfolio'];
            print("data: $data");
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(context, data),
                SizedBox(height: profileHeight / 2),
                buildNamePH(data['name'], data['telephone']),
                buildStatus(),
                PortfolioSection(title: 'Self Introduction', child: buildAbout(data['self_introduction'])),
                PortfolioSection(title: 'Work Experience', child: buildExperiences(data['work_experience'])),
                PortfolioSection(title: 'Education', child: buildEducation(data['education'])),
                PortfolioSection(title: 'Spoken Skill', child: buildLangSkills(data['spoken_skill'])),
                PortfolioSection(title: 'Written Skill', child: buildLangSkills(data['written_skill'])),
                PortfolioSection(title: 'Certificate and License', child: buildSkills(data['cert'])),
                PortfolioSection(title: 'Skill', child: buildSkills(data['skill'])),
                SizedBox(height: profileHeight / 2),
                // buildInfo(),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildTop(BuildContext context, Map data) {
    final top = coverHeight - profileHeight / 2;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.amber,
          width: double.infinity,
          height: coverHeight,
        ),
        Positioned(
          top: top,
          child: Container(
              child: (data['profile_picture'] != null)
                  ? CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      radius: profileHeight / 2,
                      backgroundImage: NetworkImage(data['profile_picture']),
                    )
                  : CircleAvatar(
                      // radius: 24,
                      radius: profileHeight / 2,
                      child: FittedBox(
                        child: Icon(Icons.supervised_user_circle),
                      ),
                    )),
        ),
      ],
    );
  }

  Widget buildStatus() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Applied", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
                  Text("5", style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            VerticalDivider(
              // width: 10,
              thickness: 2,
              color: Colors.amber,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Availability", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
                  Text("Yes", style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNamePH(String name, String phoneNumber) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 28)),
          SizedBox(height: 5),
          Text(phoneNumber, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14)),
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
          elevation: 1,
          color: Colors.amber.shade50,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${expr['start_date']} - ${_bloc.getNowFromNull(expr['end_date'])}",
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

  Widget PortfolioSection({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
