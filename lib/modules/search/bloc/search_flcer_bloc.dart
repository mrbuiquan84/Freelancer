import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_repo.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_state.dart';
import 'package:freelancer/modules/search/models/get_search_flcer_result.dart';
import 'package:freelancer/modules/search/models/search_flcer_input_model.dart';

import '../../../utils/data/error_state_action.dart';
import '../../../utils/data/load_state_actions.dart';

class SearchFlcerBloc extends Cubit<SearchFlcerState> {
  SearchFlcerBloc() : super(SearchFlcerState());

  SearchFlcerInputModel lastSearch = SearchFlcerInputModel();

  final SearchFlcerRepo _repo = SearchFlcerRepo();
  List<DataRender> flcers = [];

  reset() {
    lastSearch.page = 1;
    lastSearch.keyword = null;
    flcers = [];
  }

  Future<void> searchFlcer({
    String? keyword,
    ErrorStateActions whenError = ErrorStateActions.alert,
    LoadStateActions whenLoad = LoadStateActions.none,
  }) async {
    emit(SearchFlcerLoadState(action: whenLoad));
    if (keyword != null && keyword != lastSearch.keyword) {
      lastSearch.keyword = keyword;
    }
    var resData = await _repo.searchFlcer(input: lastSearch);
    if (resData.result) {
      try {
        var res = GetSearchFlcerResult.fromJson(resData.data);
        var flcerRes = res.dataRender;
        if (flcerRes.isEmpty && lastSearch.page != 1) {
          return emit(SearchFlcerErrorState(StringConst.endOfListError));
        }
        flcers.addAll(flcerRes);
        lastSearch.page++;
        return emit(SearchFlcerDoneState(flcers: const []));
      } catch (e, s) {
        print(e);
        print(s.toString());
        return emit(SearchFlcerErrorState(
            StringConst.errorOccurredTryAgainError,
            action: whenError));
      }
    }
    emit(SearchFlcerErrorState(
      resData.error.toString(),
      action: whenError,
    ));
  }
}
