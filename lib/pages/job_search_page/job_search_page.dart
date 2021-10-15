import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchBloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchStates.dart';
import 'package:moovup_demo/helpers/api.dart';
import 'package:moovup_demo/widgets/job_card.dart';
import 'package:moovup_demo/models/search.dart';

import 'components/SearchOption.dart';

class SearchOptionData {
  double _startMonthlySalary = 0;
  double _endMontlySalary = 999999;

  int _limit = 10;

  Map _district = {'title': 'District'};
  Map _time = {'title': 'Time'};
  List<double> _monthly_rate = [0, 999999];

  SearchOptionData.empty();

  double get startMonthlySalary => _startMonthlySalary;

  double get endMontlySalary => _endMontlySalary;

  int get limit => _limit;

  Map get district => _district;

  Map get time => _time;

  List<double> get monthly_rate => _monthly_rate;

  set monthly_rate(List<double> value) {
    _monthly_rate = value;
  }

  @override
  List<Object>? get props => [
        _startMonthlySalary,
        _endMontlySalary,
        _limit,
        _district,
        _time,
        _monthly_rate
      ];

  SearchOptionData(this._startMonthlySalary, this._endMontlySalary, this._limit,
      this._district, this._time, this._monthly_rate);
}

class JobSearchPage extends StatefulWidget {
  static const String routeName = 'job-search';
  final String title;
  final String searchCategory;

  JobSearchPage({required this.title, required this.searchCategory});

  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final _formKey = GlobalKey<FormState>();
  late SearchBloc _searchBloc;

  SearchOptionData _searchOption = new SearchOptionData.empty();

  Future<dynamic> buildModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.share),
                title: new Text('To be implemented'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _searchBloc = SearchBloc();
    // _searchBloc..add(E(widget.jobId));
  }

  getSearchOption() {
    return this._searchBloc.state.searchOption;
  }

  performSearch() {
    this._searchBloc.add(FetchSearchData(_searchOption));
  }

  changeSearchOption() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    print("${widget.title}, ${widget.searchCategory}");
    return Query(
      options: QueryOptions(
        document: gql(GraphQlQuery.getAllJobs(20)),
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        List jobs = result.data?['job_search']['result'];

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                // JobSearchForm(),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    // onSaved: (val) => setState(() => _searchOption.name = val!),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      labelText: 'Search ...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchOptionButton(
                          optionTitle: 'District',
                          buildBar: buildModalBottomSheet,
                        ),
                        SizedBox(width: 10),
                        SearchOptionButton(
                          optionTitle: 'Time',
                          buildBar: buildModalBottomSheet,
                        ),
                        SizedBox(width: 10),
                        SearchOptionButton(
                          optionTitle: 'Salary',
                          buildBar: buildModalBottomSheet,
                        ),
                      ],
                    )),
                BlocBuilder<SearchBloc, SearchStates>(
                  builder: (BuildContext context, state) {
                    if (state is LoadDataSuccess) {
                      var jobDetail = state.data['job_search']['result'];
                      print("jobDetail: $jobDetail");
                      // streamController.add(jobDetail?['job_name']);
                      // print(jobDetail?['working_hour']);
                      return ListView.builder(
                        itemCount: jobs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final jobId = jobs[index];
                          return JobCard(job: jobId);
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: jobs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final jobId = jobs[index];
                          return JobCard(job: jobId);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
