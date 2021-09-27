import 'package:flutter/material.dart';
class Job {
  String id;

  Job(this.id);

}


class SavedJobs with ChangeNotifier {
  final List<Job> _savedList = [];

  List<Job> get list {
    return [..._savedList];
  }

  saveJob(String id){
    _savedList.add(Job(id));
    notifyListeners();
  }
}

