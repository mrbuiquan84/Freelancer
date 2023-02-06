import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_repo.dart';
import 'package:freelancer/modules/profile/bloc/working_flcer_bloc/working_flcer_sate.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class WorkingFlcerBloc extends Cubit<WorkingFlcerState> {
  WorkingFlcerBloc() : super(const WorkingFlcerState()) {
    // initLoad();
    loadData();
  }

  loadData({
    int page = 1,
    int limit = 10,
    // int type = 1,
  }) async {
    var resData = await _repo.getsavedFlcer(
      page: page,
      limit: limit,
    );
    if (resData.result) {
      var res = GetFlcerProject.fromJson(resData.data);
      emit(state.copywith(
        workingflcer: [],
      ));
      emit(state.copywith(
        workingflcer: [...state.workingFlcer, ...res.list.flcWorking],
      ));
    } else {
      emit(WorkingFlcerErrorState(resData.error?.message));
    }
  }

  final SaveFlcerCardRepo _repo = SaveFlcerCardRepo();
  List<FlcWorking> flcers = [];
  int _page = 1;

  getWorkingFlcer({
    int limit = 10,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(WorkingFlcerLoadState(onLoad: onLoad));
    var resData = await _repo.getsavedFlcer(
      page: _page,
      limit: limit,
    );
    if (resData.result) {
      try {
        var res = GetFlcerProject.fromJson(resData.data);
        var workingFlcer = res.list.flcWorking;
        if (workingFlcer.isEmpty) {
          return emit(const WorkingFlcerErrorState(
            StringConst.endOfListError,
            actions: ErrorStateActions.alert,
          ));
        }
        flcers.addAll(workingFlcer);
        _page++;
        return emit(WorkingFlcerState(workingFlcer: [...flcers]));
      } catch (e, s) {
        print(e);
        print(s);
        return WorkingFlcerErrorState(
          StringConst.errorOccurredTryAgainError,
          actions: onError,
        );
      }
    } else {
      return emit(WorkingFlcerErrorState(
        resData.error,
        actions: onError,
      ));
    }
  }
}
