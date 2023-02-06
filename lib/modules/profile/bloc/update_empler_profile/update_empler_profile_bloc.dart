import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_empler_profile/update_empler_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_empler_profile/update_empler_profile_state.dart';

import '../../../../utils/data/city.dart';
import '../../../../utils/data/gender.dart';
import '../../../signup/model/post_update_empler_profile_result.dart';

class UpdateEmplerProfileBloc extends Cubit<UpdateEmplerProfileState> {
  UpdateEmplerProfileBloc({
    required this.appRepo,
  }) : super(UpdateEmplerProfileInitState()) {
    _preload();
  }
  _preload() async {
    emit(UpdateEmplerProfileInitState());
  }

  final AppRepo appRepo;
  final UpdateEmperProfileRepo updateRepo = const UpdateEmperProfileRepo();

  updateEmpler({
    required String name,
    required Gender gender,
    required City city,
    required City district,
    required String birthday,
    required String phone,
    MultipartFile? avatarUser,
    // int? siteFrom,
  }) async {
    emit(UpdateEmplerProfileLoadState());
    var res = await updateRepo.updateEmplerProfileRepo(
      name: name,
      gender: gender.id,
      city: city.citId,
      district: district.citId,
      birthday: birthday,
      // updateAt: DateTime.now(),
      phone: phone,
      // siteFrom: 0,
      avatar: avatarUser,
    );
    if (!res.result) {
      emit(UpdateEmplerProfileErrorState(res.error.toString()));
    } else {
      res.data = PostUpdateEmplerProfileResult.fromJson(res.data);
      emit(UpdateEmplerProfileSuccessState(res.message.toString()));
    }
  }
}
