import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_bloc.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_events.dart';
import 'package:moovup_demo/blocs/BookmarkBloc/bookmark_states.dart';
import 'package:moovup_demo/widgets/job_card.dart';

class SavedJobPage extends StatefulWidget {
  const SavedJobPage({Key? key}) : super(key: key);
  static const routeName = '/saved-jobs';

  @override
  State<SavedJobPage> createState() => _SavedJobPageState();
}

class _SavedJobPageState extends State<SavedJobPage> {
  @override
  void initState() {
    BlocProvider.of<BookmarkBloc>(context)..add(FetchBookmarkData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Jobs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.manage_search),
            tooltip: 'Show Search Bar',
          ),
        ],
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkStates>(
        builder: (context, state) {
          if (state is LoadDataSuccess) {
            final total = state.data['saved_jobs']['total'];
            final bookmarks = state.data['saved_jobs']['bookmarks'];
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: total,
                itemBuilder: (context, index) => JobCard(job: bookmarks[index]['job']));
          } else if (state is OnLoading) {
            return LinearProgressIndicator();
          } else {
            return Text('Empty');
          }
        },
      ),
    );
  }
}
