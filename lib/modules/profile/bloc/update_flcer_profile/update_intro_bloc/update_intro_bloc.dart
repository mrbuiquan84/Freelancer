import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_flcer_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_flcer_profile_state.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_intro_bloc/update_intro_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_intro_bloc/update_intro_state.dart';
import 'package:freelancer/modules/signup/model/post_update_flcer_profile_result.dart';
import 'package:freelancer/utils/data/city.dart';

class UpdateIntroBloc extends Cubit<UpdateIntroState> {
  UpdateIntroBloc({
    required this.appRepo,
  }) : super(UpdateIntroInitState()) {
    _preload();
  }
  _preload() async {
    emit(UpdateIntroInitState());
  }

  final AppRepo appRepo;
  final UpdateIntroRepo updateRepo = const UpdateIntroRepo();

  updateIntro({
    required int expYear,
    required String intro,
  }) async {
    emit(UpdateIntroLoadState());
    var res = await updateRepo.updateIntroRepo(expYear: expYear, intro: intro);
    if (!res.result) {
      emit(UpdateIntroErrorState(res.error.toString()));
    } else {
      // res.data = PostUpdateFlcerProfileResult.fromJson(res.data);
      emit(UpdateIntroSuccessState(res.message.toString()));
    }
  }
}
