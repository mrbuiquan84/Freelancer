import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_repo.dart';
import 'package:freelancer/modules/profile/bloc/working_flcer_bloc/working_flcer_sate.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

import 'had_set_price_state.dart';

class HadSetPriceBloc extends Cubit<HadSetPriceState> {
  HadSetPriceBloc() : super(const HadSetPriceState()) {
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
        flcerPrice: [],
      ));
      emit(state.copywith(
        flcerPrice: [...state.flcerPrice, ...res.list.flcPriceSetted],
      ));
    } else {
      emit(HadSetPriceErrorState(resData.error?.message));
    }
  }

  final SaveFlcerCardRepo _repo = SaveFlcerCardRepo();
  List<FlcPrice> flcers = [];
  int _page = 1;

  getWorkingFlcer({
    int limit = 10,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(HadSetPriceLoadState(onLoad: onLoad));
    var resData = await _repo.getsavedFlcer(
      page: _page,
      limit: limit,
    );
    if (resData.result) {
      try {
        var res = GetFlcerProject.fromJson(resData.data);
        var flcerPrice = res.list.flcPriceSetted;
        if (flcerPrice.isEmpty) {
          return emit(const HadSetPriceErrorState(
            StringConst.endOfListError,
            actions: ErrorStateActions.alert,
          ));
        }
        flcers.addAll(flcerPrice);
        _page++;
        return emit(HadSetPriceState(flcerPrice: [...flcers]));
      } catch (e, s) {
        print(e);
        print(s);
        return HadSetPriceErrorState(
          StringConst.errorOccurredTryAgainError,
          actions: onError,
        );
      }
    } else {
      return emit(HadSetPriceErrorState(
        resData.error,
        actions: onError,
      ));
    }
  }
}
