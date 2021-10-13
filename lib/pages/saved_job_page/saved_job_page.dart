import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_bloc.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_events.dart';

class SavedJobPage extends StatelessWidget {
  const SavedJobPage({Key? key}) : super(key: key);
  static const routeName = '/saved-jobs';

  @override
  Widget build(BuildContext context) {
    final List dummyList = List.generate(1000, (index) {
      return {
        "id": index,
        "title": "This is the title $index",
        "subtitle": "This is the subtitle $index"
      };
    });

    return BlocProvider<BookmarkBloc>(
      create: (BuildContext context) =>
          BookmarkBloc()..add(FetchBookmarkData()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Saved Jobs'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.manage_search),
                tooltip: 'Show Search Bar',
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: dummyList.length,
            itemBuilder: (context, index) => Card(
              elevation: 6,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(dummyList[index]["id"].toString()),
                  backgroundColor: Colors.purple,
                ),
                title: Text(dummyList[index]["title"]),
                subtitle: Text(dummyList[index]["subtitle"]),
                trailing: Icon(Icons.add_a_photo),
              ),
            ),
          )),
    );
  }
}
