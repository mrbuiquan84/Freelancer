import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/get_posted_job.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_repo.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_state.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../utils/data/error_state_action.dart';
import '../../../../utils/data/load_state_actions.dart';

class PostedJobBloc extends Cubit<PostedJobState> {
  PostedJobBloc() : super(const PostedJobState()) {
    initLoad();
    // loadData();
  }

  final PostedJobRepo _repo = PostedJobRepo();
  List<PostedJob> jobs = [];
  void initLoad() {
    getPostedJob(
      onError: ErrorStateActions.rebuild,
      onLoad: LoadStateActions.rebuild,
    );
  }

  // loadData({
  //   int page = 1,
  //   int limit = 10,
  //   // int type = 1,
  // }) async {
  //   var resData = await _repo.getpostedJob(
  //     page: page,
  //     limit: limit,
  //   );
  //   if (resData.result) {
  //     var res = GetPostedJob.fromJson(resData.data);
  //     emit(state.copywith(
  //       postedJob: [],
  //     ));
  //     emit(state.copywith(
  //       postedJob: [...state.postedJob, ...res.infor],
  //     ));
  //   } else {
  //     emit(PostedJobErrorState(resData.error?.message));
  //   }
  // }

  getPostedJob({
    LoadStateActions onLoad = LoadStateActions.rebuild,
    ErrorStateActions onError = ErrorStateActions.rebuild,
  }) async {
    emit(PostedJobLoadState(onLoad: onLoad));
    var resData = await _repo.getpostedJob(
      page: 1,
      limit: 10,
    );
    if (resData.result) {
      try {
        var res = GetPostedJob.fromJson(resData.data);
        var postedJob = res.infor;
        if (postedJob.isEmpty) {
          return emit(const PostedJobErrorState(
            StringConst.endOfListError,
            action: ErrorStateActions.alert,
          ));
        }
        jobs.addAll(postedJob);
        return emit(PostedJobState(postedJob: [...jobs]));
      } catch (e, s) {
        print(e);
        print(s);
        return PostedJobErrorState(
          StringConst.errorOccurredTryAgainError,
          action: onError,
        );
      }
    } else {
      return emit(
        PostedJobErrorState(
          resData.error,
          action: onError,
        ),
      );
    }
  }
}
