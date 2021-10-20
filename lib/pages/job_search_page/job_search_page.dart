import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchBloc.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchEvents.dart';
import 'package:moovup_demo/blocs/SearchBloc/SearchStates.dart';
import 'package:moovup_demo/models/search_option_data.dart';
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
    _searchBloc = SearchBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;

    // print() For implmentation
    print("${widget.title}, ${widget.searchCategory}");
    var _termController = TextEditingController();

    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          // height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _termController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (term) {
                      _searchBloc.add(UpdateTerm(term));
                    },
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
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      _searchBloc.add(ResetSearch());
                    },
                    child: const Text('Reset'),
                  ),
                ),
                Container(
                  child: BlocBuilder<SearchBloc, SearchStates>(
                    builder: (context, state) {
                      if (state is LoadDataSuccess) {
                        var jobDetail = state.data['job_search']['result'];
                        return ListView.builder(
                          itemCount: jobDetail.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final jobId = jobDetail[index];
                            return JobCard(job: jobId);
                          },
                        );
                      } else if (state is EmptyState) {
                        return ValueListenableBuilder(
                          valueListenable:
                              _searchBloc.recentSearchBox.listenable(),
                          builder: (context, Box box, widget) {
                            if (box.isEmpty) {
                              return Center(child: Text('Empty'));
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  var currentBox = box;
                                  var data = currentBox.getAt(index)!;
                                  return InkWell(
                                    child: Card(
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      child: ListTile(
                                        title: Text(data, style: TextStyle(fontSize: 16),),
                                        trailing: IconButton(
                                          onPressed: () => _searchBloc.deleteSearchHive(index),
                                          icon: Icon(
                                            Icons.delete,
                                            // color: Colors.red,
                                          ),
                                        ),
                                        dense: true,
                                      ),
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
                        return Container(
                            height: MediaQuery.of(context).size.height - 400,
                            child: Text("Empty"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
