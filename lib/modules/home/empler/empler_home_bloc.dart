import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/home/empler/empler_home_repo.dart';
import 'package:freelancer/modules/home/empler/empler_home_state.dart';
import 'package:freelancer/modules/home/empler/get_empler_home_data_result.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../core/constants/string_constants.dart';
import '../../../utils/data/error_state_action.dart';
import '../../../utils/data/load_state_actions.dart';

class EmplerHomeBloc extends Cubit<EmplerHomeState> {
  EmplerHomeBloc() : super(const EmplerHomeState()) {
    loadData();
  }
  final EmplerHomeRepo _repo = EmplerHomeRepo();

  loadData({
    int page = 1,
    int limit = 10,
    // int type = 1,
  }) async {
    var resData = await _repo.loadData(
      page: page,
      limit: limit,
      // type: type,
    );
    if (resData.result) {
      var res = GetEmplerHomeDataResult.fromJson(resData.data);
      emit(state.copyWith(
        flcers: [],
      ));
      emit(state.copyWith(
        flcers: [...state.flcers, ...res.info],
      ));
    } else {
      emit(EmplerHomeErrorState(resData.error?.message));
    }
  }

  int _page = 1;
  List<Info> listFlcer = [];
  getFlcers({
    int limit = kFlcerPriceProjectLimit,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(EmplerHomeLoadState());
    var resData = await _repo.loadData(
      page: _page,
      limit: 15,
    );
    if (resData.result) {
      try {
        var res = GetEmplerHomeDataResult.fromJson(resData.data);
        var flcers = res.info;
        if (flcers.isEmpty) {
          return emit(const EmplerHomeErrorState(
            StringConst.endOfListError,
          ));
        }
        listFlcer.addAll(flcers);
        _page++;
        return emit(EmplerHomeState(flcers: [...listFlcer]));
      } catch (e, s) {
        print(e);
        print(s);
        return EmplerHomeErrorState(
          StringConst.errorOccurredTryAgainError,
        );
      }
    } else {
      return emit(EmplerHomeErrorState(
        resData.error,
      ));
    }
  }
}
