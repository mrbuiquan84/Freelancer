import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/flcer_detail_repo.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/flcer_detail_state.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/post_flcer_detail_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class FlcerDetailBloc extends Cubit<FlcerDetailState> {
  FlcerDetailBloc(this.flcerId) : super(FlcerDetailLoadState()) {
    loadFlcerDetail();
  }
  final String flcerId;
  final FlcerDetailRepo repo = FlcerDetailRepo();

  loadFlcerDetail({
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(FlcerDetailLoadState(action: onLoad));
    var resData = await repo.getFlcerDetai(flcerId: flcerId);
    if (resData.result) {
      try {
        var res = PostFlcerDetailResult.fromJson(resData.data);
        return emit(FlcerDetailDoneState(info: res.info));
      } catch (e, s) {
        print(e);
        print(s);
        return emit(FlcerDetailErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        ));
      }
    } else {
      return emit(FlcerDetailErrorState(
        resData.error,
        action: onError,
      ));
    }
  }
}
