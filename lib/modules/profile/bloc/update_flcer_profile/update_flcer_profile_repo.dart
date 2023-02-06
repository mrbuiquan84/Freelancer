import 'package:dio/dio.dart';
import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

import '../../../../common/services/share_pref/pref_service.dart';
import '../../../../core/constants/string_constants.dart';

class UpdateFlcerProfileRepo {
  const UpdateFlcerProfileRepo();

  Future<ResultData> updateFlcerProfileRepo({
    required String name,
    required int gender,
    required int city,
    required int district,
    required String birthday,
    MultipartFile? avatarUser,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    var body = {
      "token": prefs.getString(StringConst.tokenKey),
      "name": name,
      "birthday": birthday,
      "sex": gender,
      "city_id": city,
      "district_id": district,
      "avatar_user": avatarUser,
    };

    return await httpManager.netFetch(
      ApiAddress.updateInfoFlcer,
      method: 'post',
      params: body,
      isFormData: true,
    );
  }
}
