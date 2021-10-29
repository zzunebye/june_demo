import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_bloc.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_events.dart';
import 'package:moovup_demo/blocs/PortfolioBloc/portfolio_states.dart';
import 'package:moovup_demo/pages/portfolio_edit_page/portfolio_edit_page.dart';
import 'package:moovup_demo/widgets/job_type_pill.dart';
import 'package:moovup_demo/widgets/portfolio_contents.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);
  static String routeName = 'portfolio';

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final double coverHeight = 180;
  final double profileHeight = 120;

  @override
  void initState() {
    // BlocProvider.of<PortfolioBloc>(context).add(FetchPortfolio());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).primaryColor,
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
            var data = (state).data;
            print(data);
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(context, data),
                SizedBox(height: profileHeight / 2),
                buildNamePH(data['name'], data['telephone']),
                buildStatus(),
                PortfolioContents(data),
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
          color: Colors.teal,
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
                  ),
          ),
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
              thickness: 2,
              color: Theme.of(context).canvasColor,
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
