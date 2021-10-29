import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/models/job_application.dart';
import 'package:moovup_demo/repositories/job_repository.dart';

import 'apply_job_events.dart';
import 'apply_job_states.dart';

class ApplyJobBloc extends Bloc<ApplyJobEvents, ApplyJobStates> {
  late PostRepository userRepository;

  ApplyJobBloc(this.userRepository) : super(OnLoading()) {
    on<FetchApplyJob>(_onFetchApplyJob);
    on<ApplyJob>(_onApplyJob);
  }

  _onFetchApplyJob(ApplyJobEvents event, Emitter<ApplyJobStates> emit) async {
    emit(OnLoading());
  }

  _onApplyJob(ApplyJob event, Emitter<ApplyJobStates> emit) async {
    emit(OnLoading());

    try {
      print("${event.jobApplication.jobId} & ${event.jobApplication.addressIds}");
      final result = await userRepository.applyJob(event.jobApplication);
      emit(ApplyJobSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
  }

  String getNowFromNull(String date) {
    return (date != null) ? date : 'Now';
  }
}
