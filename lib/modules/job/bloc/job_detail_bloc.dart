import 'package:bloc/bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/job/bloc/job_detail_repo.dart';
import 'package:freelancer/modules/job/bloc/job_detail_state.dart';
import 'package:freelancer/modules/job/model/post_job_detail_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class JobDetailBloc extends Cubit<JobDetailState> {
  JobDetailBloc(this.jobId) : super(JobDetailLoadState()) {
    loadJobDetail();
  }

  final String jobId;
  final JobDetailRepo repo = JobDetailRepo();

  loadJobDetail({
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(JobDetailLoadState(action: onLoad));
    var resData = await repo.getJobDetail(jobId: jobId);
    if (resData.result) {
      try {
        var res = PostJobDetailResult.fromJson(resData.data);
        return emit(JobDetailDoneState(
          info: res.info,
          jobsSame: res.jobsSame,
          listsFlc: res.listsFlc,
        ));
      } catch (e, s) {
        print(e);
        print(s);
        return emit(JobDetailErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        ));
      }
    } else {
      return emit(JobDetailErrorState(
        resData.error,
        action: onError,
      ));
    }
  }
}
