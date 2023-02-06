import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/profile/bloc/ongoing_project_bloc/ongoing_project_repo.dart';
import 'package:freelancer/modules/profile/bloc/ongoing_project_bloc/ongoing_project_state.dart';
import 'package:freelancer/modules/profile/models/get_saved_ongoing_project_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class OngoingProjectBloc extends Cubit<OngoingProjectState> {
  OngoingProjectBloc() : super(const OngoingProjectState()) {
    initLoad();
  }

  initLoad() {
    getOngoingProject(
      onError: ErrorStateActions.rebuild,
      onLoad: LoadStateActions.rebuild,
    );
  }

  final OngoingProjectRepo _repo = OngoingProjectRepo();
  List<FlcGoingJob> jobs = [];
  int _page = 1;

  getOngoingProject({
    int limit = kFlcerOngoingProjectLimit,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(OngoingProjectLoadState(onLoad: onLoad));
    var resData = await _repo.getOngoingProject(
      page: _page,
      limit: limit,
    );
    if (resData.result) {
      try {
        var res = GetSavedOngoingProjectResult.fromJson(resData.data);
        var goingJob = res.dataRender.flcGoingJob;
        if (goingJob.isEmpty) {
          return emit(const OngoingProjectErrorState(
            StringConst.endOfListError,
            action: ErrorStateActions.alert,
          ));
        }
        jobs.addAll(goingJob);
        _page++;
        return emit(OngoingProjectState(goingJob: [...jobs]));
      } catch (e, s) {
        print(e);
        print(s);
        return OngoingProjectErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        );
      }
    } else {
      return emit(
        OngoingProjectErrorState(
          resData.error,
          action: onError,
        ),
      );
    }
  }
}
