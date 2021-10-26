import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchBloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchStates.dart';
import 'package:moovup_demo/widgets/job_card.dart';

import 'components/SearchOption.dart';

class JobSearchPage extends StatefulWidget {
  static const String routeName = 'job-search';
  final String title;
  final String searchCategory;

  JobSearchPage({required this.title, this.searchCategory = ''});

  @override
  _JobSearchPageState createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    // _searchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    var _termController = TextEditingController();

    Widget buildSearchBar() {
      return Container(
        margin: const EdgeInsets.all(15),
        child: TextFormField(
          controller: _termController,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (term) {
            _searchBloc.add(UpdateTerm(term));
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            labelText: 'Search ...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      );
    }

    Widget buildSearchOptions() {
      return Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchOptionButton(
              optionTitle: 'District',
            ),
            const SizedBox(width: 10),
            SearchOptionButton(
              optionTitle: 'Time',
            ),
            const SizedBox(width: 10),
            SearchOptionButton(
              optionTitle: 'Salary',
            ),
          ],
        ),
      );
    }

    Widget buildResetButton() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () {
            _searchBloc.add(ResetSearch());
            setState(() {
              _termController.text = '';
            });
          },
          child: const Text('Reset'),
        ),
      );
    }

    Widget buildRecentSearchList() {
      return Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: BlocBuilder<SearchBloc, SearchStates>(
          builder: (context, state) {
            if (state is LoadDataSuccess) {
              var jobDetail = state.data['job_search']['result'];
              return ListView.builder(
                itemCount: jobDetail.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return JobCard(job: jobDetail[index]);
                },
              );
            } else if (state is EmptyState) {
              return ValueListenableBuilder(
                valueListenable: _searchBloc.recentSearchBox.listenable(),
                builder: (context, Box box, widget) {
                  if (box.isEmpty) {
                    return Center(child: Text('Empty'));
                  } else {
                    List<dynamic> boxValues = box.values.take(10).toList().reversed.toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: boxValues.length,
                      itemBuilder: (context, index) {
                        String data = boxValues.elementAt(index)!;
                        return InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Theme.of(context).cardColor,
                          splashColor: Colors.deepPurpleAccent,
                          onTap: () => _searchBloc.add(UpdateTerm(data)),
                          child: ListTile(
                            tileColor: Theme.of(context).cardColor,
                            title: Text(
                              data,
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: IconButton(
                              onPressed: () => _searchBloc.deleteSearchHive(index),
                              icon: const Icon(Icons.delete),
                            ),
                            dense: true,
                          ),
                        );
                      },
                    );
                  }
                },
              );
            } else if (state is OnLoading) {
              return LinearProgressIndicator();
            } else {
              return Container(height: MediaQuery.of(context).size.height - 400, child: Text("Empty"));
            }
          },
        ),
      );
    }

    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSearchBar(),
                buildSearchOptions(),
                buildResetButton(),
                buildRecentSearchList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
