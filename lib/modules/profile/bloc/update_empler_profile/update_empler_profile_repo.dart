import 'package:dio/dio.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/core/constants/string_constants.dart';

import '../../../../common/services/http/api.dart';
import '../../../../common/services/http/api_address.dart';
import '../../../../common/services/share_pref/pref_service.dart';

class UpdateEmperProfileRepo {
  const UpdateEmperProfileRepo();

  Future<ResultData> updateEmplerProfileRepo({
    required String name,
    required int gender,
    required int city,
    required int district,
    required String birthday,
    required String phone,
    MultipartFile? avatar,
    // required DateTime updateAt,
    // int? siteFrom,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    var body = {
      "token": prefs.getString(StringConst.tokenKey),
      "name": name,
      "birthday": birthday,
      "sex": gender,
      "city_id": city,
      "district_id": district,
      "phone": phone,
      // 'updated_at': DateTime.now().toString(),
      // "site_from": 0,
      "avatar_user": avatar,
    };

    return await httpManager.netFetch(
      ApiAddress.updateEmplerProfile,
      method: 'post',
      params: body,
      isFormData: true,
    );
  }
}
