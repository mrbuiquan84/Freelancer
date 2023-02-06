import 'package:bloc/bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/search/bloc/search_repo.dart';
import 'package:freelancer/modules/search/bloc/search_state.dart';
import 'package:freelancer/modules/search/models/get_search_job_result.dart';
import 'package:freelancer/modules/search/models/search_input_model.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState());

  SearchInputModel lastSearch = SearchInputModel();

  final SearchRepo _repo = SearchRepo();
  List<JobModel2> jobs = [];

  reset() {
    lastSearch.page = 1;
    lastSearch.keyword = null;
    jobs = [];
  }

  Future<void> searchJob({
    String? keyword,
    ErrorStateActions whenError = ErrorStateActions.alert,
    LoadStateActions whenLoad = LoadStateActions.none,
  }) async {
    emit(SearchLoadState(action: whenLoad));
    // await Future.delayed(const Duration(seconds: 5));
    if (keyword != null && keyword != lastSearch.keyword) {
      lastSearch.keyword = keyword;
    }
    var resData = await _repo.searchJob(input: lastSearch);
    if (resData.result) {
      try {
        var res = GetSearchJobResult.fromJson(resData.data);
        var jobsRes = res.dataRender;
        if (jobsRes.isEmpty && lastSearch.page != 1) {
          return emit(SearchErrorState(StringConst.endOfListError));
        }
        jobs.addAll(jobsRes);
        lastSearch.page++;
        return emit(SearchDoneState(jobs: const []));
      } catch (e, s) {
        print(e);
        print(s.toString());
        return emit(SearchErrorState(
          StringConst.errorOccurredTryAgainError,
          action: whenError,
        ));
      }
    }
    emit(SearchErrorState(
      resData.error.toString(),
      action: whenError,
    ));
  }
}
