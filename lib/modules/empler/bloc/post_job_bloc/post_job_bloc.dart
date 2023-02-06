import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/empler/bloc/post_job_bloc/post_job_repo.dart';
import 'package:freelancer/modules/empler/bloc/post_job_bloc/post_job_sate.dart';

class PostJobBloc extends Cubit<PostJobState> {
  PostJobBloc() : super((PostJobInitState())) {
    _preload();
  }

  // final AppRepo appRepo;
  final PostJobRepo postJobRepo = const PostJobRepo();

  _preload() async {
    emit(PostJobInitState());
  }

  postJob({
    MultipartFile? companyLogo,
    required String titleJob,
    required int categoryID,
    required int workType,
    required int workCity,
    required int workExp,
    required String workDes,
    MultipartFile? workFileDes,
    required List<int> skillId,
    required int salaryType,
    required String salaryNumber,
    required int salaryDate,
    required String startDay,
    required String endDay,
    required String startWorkDay,
    required int jobType,
    required int workingTerm,
  }) async {
    emit(PostJobLoadState());
    var res = await postJobRepo.postJob(
        titleJob: titleJob,
        categoryID: categoryID,
        workType: workType,
        workCity: workCity,
        workExp: workExp,
        workDes: workDes,
        skillId: skillId,
        salaryType: salaryType,
        salaryNumber: salaryNumber,
        salaryDate: salaryDate,
        startDay: startDay,
        endDay: endDay,
        startWorkDay: startWorkDay,
        jobType: jobType,
        workingTerm: workingTerm);

    if (res.result) {
      emit(PostJobDoneState());
    } else {
      emit(PostJobSErrorState(res.error.toString()));
    }
  }
}
