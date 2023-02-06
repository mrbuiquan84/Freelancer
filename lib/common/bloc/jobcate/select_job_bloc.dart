import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/jobcate/jobcate_state.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';

class JobBloc extends Cubit<JobcateState> {
  JobBloc(
    JobcateState initialState, {
    required this.appRepo,
  }) : super(initialState);
  final AppRepo appRepo;

  getSkill(int id) async {
    emit(JobcateLoadState());
    print('call');
    var res = await _getSkill(id);
    if (res.result) {
      emit(SkillListState(res.data));
      return;
    }
    emit(JobcateErrorState(res.error?.message ?? res.message));
  }

  Future<ResultData> _getSkill(int id) async =>
      await appRepo.getListJobCate(id: id);
}
