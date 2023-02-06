import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/flcer_order_job/bloc/flcer_order_job_state.dart';
import 'package:freelancer/modules/profile/bloc/price_project_bloc/price_project_repo.dart';
import 'package:freelancer/modules/profile/models/get_price_project_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../../core/constants/string_constants.dart';
import 'price_project_state.dart';

class PriceProjectBloc extends Cubit<PriceProjectState> {
  PriceProjectBloc() : super(const PriceProjectState()) {
    initLoad();
  }

  void initLoad() {
    getPriceProject(
      onError: ErrorStateActions.rebuild,
      onLoad: LoadStateActions.rebuild,
    );
  }

  final PriceProjectRepo _repo = PriceProjectRepo();
  List<PriceProject> jobs = [];
  int _page = 1;
  getPriceProject({
    int limit = kFlcerPriceProjectLimit,
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(PriceProjectLoadState(onLoad: onLoad));
    var resData = await _repo.getPriceProject(
      page: _page,
      limit: limit,
    );
    if (resData.result) {
      try {
        var res = GetPriceProjectResult.fromJson(resData.data);
        var priceProject = res.list;
        if (priceProject.isEmpty) {
          return emit(const PriceProjectErrorState(
            StringConst.endOfListError,
            action: ErrorStateActions.alert,
          ));
        }
        jobs.addAll(priceProject);
        _page++;
        return emit(PriceProjectState(priceProject: [...jobs]));
      } catch (e, s) {
        print(e);
        print(s);
        return PriceProjectErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        );
      }
    } else {
      return emit(PriceProjectErrorState(
        resData.error,
        action: onError,
      ));
    }
  }
}
