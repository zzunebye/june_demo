import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/job_application.dart';
import 'package:moovup_demo/repositories/job_repository.dart';
import 'package:intl/intl.dart';

part 'my_application_event.dart';

part 'my_application_state.dart';

class MyApplicationBloc extends Bloc<MyApplicationEvent, MyApplicationState> {
  late PostRepository userRepository;

  MyApplicationBloc(this.userRepository) : super(MyApplicationInitial()) {
    on<MyApplicationEvent>((event, emit) {
      print('MyApplicationEvent');
    });
    on<FetchApplications>((event, emit) async {
      print('onFetchApplications');

      emit(MyApplicationOnLoading());

      try {
        var result;
        switch (event.applicationType) {
          case FetchApplicationsType.ALL:
            result = await userRepository.getApplications(ApplicationsInfo());
            break;
          case FetchApplicationsType.REVIEWED:
            result = await userRepository.getApplications(ApplicationsInfo(status: 'Reviewed'));
            break;
          case FetchApplicationsType.REJECTED:
            result = await userRepository.getApplications(ApplicationsInfo(status: 'Rejected'));
            break;
          default:
            result = await userRepository.getApplications(ApplicationsInfo());
            break;
        }
        // final result = await userRepository.getApplications(ApplicationsInfo());
        if (result.data['get_applications']['total'] == 0) {
          emit(MyApplicationEmpty());
        } else {
          emit(MyApplicationDataSuccess(result.data));
        }
      } catch (error) {
        emit(MyApplicationDataFail(error));
      }
    });
  }

  String convertDateTime(String dateData) {
    return "${DateFormat("yyyy / MM / dd hh:mm").format(DateTime.parse(dateData))}";
  }
}
