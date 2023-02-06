import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_repo.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_state.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class SaveFlcerCardBloc extends Cubit<SavedFlcerCardState> {
  SaveFlcerCardBloc() : super(const SavedFlcerCardState()) {
    // initLoad();
    loadData();
  }
  // void initLoad() {
  //   getSavedFlcer(
  //     onError: ErrorStateActions.rebuild,
  //     onLoad: LoadStateActions.rebuild,
  //   );
  // }

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
        savedflcers: [],
      ));
      emit(state.copywith(
        savedflcers: [...state.savedFlcer, ...res.list.savedFlc],
      ));
    } else {
      emit(SaveFlcerErrorState(resData.error?.message));
    }
  }

  final SaveFlcerCardRepo _repo = SaveFlcerCardRepo();
  List<SavedFlc> flcers = [];
  int _page = 1;

  getSavedFlcer({
    int limit = 10,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(SavedFlcerLoadState(onLoad: onLoad));
    var resData = await _repo.getsavedFlcer(
      page: _page,
      limit: limit,
    );
    if (resData.result) {
      try {
        var res = GetFlcerProject.fromJson(resData.data);
        var savedFlcer = res.list.savedFlc;
        if (savedFlcer.isEmpty) {
          return emit(const SaveFlcerErrorState(
            StringConst.endOfListError,
            actions: ErrorStateActions.alert,
          ));
        }
        flcers.addAll(savedFlcer);
        _page++;
        return emit(SavedFlcerCardState(savedFlcer: [...flcers]));
      } catch (e, s) {
        print(e);
        print(s);
        return SaveFlcerErrorState(
          StringConst.errorOccurredTryAgainError,
          actions: onError,
        );
      }
    } else {
      return emit(SaveFlcerErrorState(
        resData.error,
        actions: onError,
      ));
    }
  }
}
