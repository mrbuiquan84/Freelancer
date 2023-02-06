import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_flcer_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_flcer_profile_state.dart';
import 'package:freelancer/modules/signup/model/post_update_flcer_profile_result.dart';
import 'package:freelancer/utils/data/city.dart';

import '../../../../utils/data/gender.dart';

class UpdateFlcerProfileBloc extends Cubit<UpdateFlcerProfileState> {
  UpdateFlcerProfileBloc({
    required this.appRepo,
  }) : super(UpdateFlcerProfileInitState()) {
    _preload();
  }
  _preload() async {
    emit(UpdateFlcerProfileInitState());
  }

  final AppRepo appRepo;
  final UpdateFlcerProfileRepo updateRepo = const UpdateFlcerProfileRepo();

  updateFlcer({
    required String name,
    required Gender gender,
    required City city,
    required City district,
    required String birthday,
    MultipartFile? avatarUser,
    // int? siteFrom,
  }) async {
    emit(UpdateFlcerProfileLoadState());
    var res = await updateRepo.updateFlcerProfileRepo(
      name: name,
      gender: gender.id,
      city: city.citId,
      district: district.citId,
      birthday: birthday,
      // updatedAt: DateTime.now(),
      // siteFrom: 0,
      avatarUser: avatarUser,
    );
    if (!res.result) {
      emit(UpdateFlcerProfileErrorState(res.error.toString()));
    } else {
      res.data = PostUpdateFlcerProfileResult.fromJson(res.data);
      emit(UpdateFlcerProfileSuccessState(res.message.toString()));
    }
  }
}
