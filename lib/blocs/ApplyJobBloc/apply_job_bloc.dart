import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovup_demo/repositories/job_repository.dart';

import 'apply_job_events.dart';
import 'apply_job_states.dart';


class ApplyJobBloc extends Bloc<ApplyJobEvents, ApplyJobStates> {
  late PostRepository userRepository;

  ApplyJobBloc(this.userRepository) : super(OnLoading()) {
    on<FetchApplyJob>(_onFetchApplyJob);
  }

  _onFetchApplyJob(ApplyJobEvents event, Emitter<ApplyJobStates> emit) async {

    emit(OnLoading());

    try {
      final result = await userRepository.applyJob({});
      emit(LoadDataSuccess(result.data));
    } catch (error) {
      emit(LoadDataFail(error));
    }
  }

  String getNowFromNull(String date) {
    return (date != null) ? date : 'Now';
  }
}
