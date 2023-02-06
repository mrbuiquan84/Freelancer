import 'package:bloc/bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_repo.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_state.dart';
import 'package:freelancer/modules/profile/models/get_saved_ongoing_project_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SavedProjectBloc extends Cubit<SavedProjectState> {
  SavedProjectBloc() : super(const SavedProjectState()) {
    loadData();
  }

  loadData() {
    getSavedProject(
      onError: ErrorStateActions.rebuild,
      onLoad: LoadStateActions.rebuild,
    );
  }

  final SavedProjectRepo _repo = SavedProjectRepo();
  List<FlcSaveJob> jobs = [];
  int _page = 1;

  getSavedProject({
    int limit = kFlcerSavedProjectLimit,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    // emit(SavedProjectLoadState(onLoad: onLoad));
    var resData = await _repo.getFlcerSavedProject(
      page: _page,
      limit: limit,
    );
    if (resData.result) {
      try {
        var res = GetSavedOngoingProjectResult.fromJson(resData.data);
        var savedJobs = res.dataRender.flcSaveJob;
        if (savedJobs.isEmpty) {
          return emit(const SavedProjectErrorState(
            StringConst.endOfListError,
            action: ErrorStateActions.alert,
          ));
        }
        jobs.addAll(savedJobs);
        _page++;
        return emit(SavedProjectState(savedJobs: [...jobs]));
      } catch (e, s) {
        print(e);
        print(s);
        return SavedProjectErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        );
      }
    } else {
      return emit(
        SavedProjectErrorState(
          resData.error,
          action: onError,
        ),
      );
    }
  }

  deleteSavedJob(String id) async {
    emit(const SavedProjectLoadState());
    var resData = await _repo.deleteSavedProject(jobId: id);
    if (resData.result) {
      jobs.removeWhere((e) => e.id == id);
      emit(SavedProjectDeleteSuccessState(id));
    } else {
      emit(SavedProjectErrorState(resData.error));
    }
  }
}
