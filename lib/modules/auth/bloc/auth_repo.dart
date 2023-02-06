import 'dart:async';

import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/auth/model/auth_status.dart';
import 'package:freelancer/modules/profile/bloc/empler_profile_bloc/empler_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/flcer_profile_bloc/flcer_profile_repo.dart';
import 'package:freelancer/utils/data/user_type.dart';

class AuthRepo {
  final _controller = StreamController<AuthStatus>();
  final FlcerProfileRepo flcerProfileRepo = FlcerProfileRepo();
  final EmplerProfileRepo emplerProfileRepo = EmplerProfileRepo();

  Stream<AuthStatus> get status async* {
    yield AuthStatus.unknown;
    yield* _controller.stream;
  }

  Future<ResultData> getCurrentUserInfo({
    required UserType userType,
  }) async {
    if (userType == UserType.freelancer) {
      return await flcerProfileRepo.getFlcerProfile();
    } else if (userType == UserType.employer) {
      return await emplerProfileRepo.getEmplerProfile();
    } else {
      return ResultData();
    }
  }

  checkLocalStorageToken() {
    //check token exists in local storage
    return prefs.containsKey(StringConst.tokenKey);
  }

  Future<ResultData> loginFlcer({
    required email,
    required password,
  }) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    return await httpManager.netFetch(
      ApiAddress.loginFlcer,
      params: body,
      method: 'post',
      isFormData: true,
    );
  }

  Future<ResultData> loginEmpler({
    required email,
    required password,
  }) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    return await httpManager.netFetch(
      ApiAddress.loginEmpler,
      params: body,
      method: 'post',
      isFormData: true,
    );
  }

  Future<String?> logout() async {
    try {
      await prefs.clear();
    } catch (e) {
      return e.toString();
    }
  }

  void dispose() {
    _controller.close();
  }
}
