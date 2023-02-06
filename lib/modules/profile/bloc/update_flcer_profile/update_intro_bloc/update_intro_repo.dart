import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class UpdateIntroRepo {
  const UpdateIntroRepo();

  Future<ResultData> updateIntroRepo({
    required int expYear,
    required String intro,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return await httpManager.netFetch(ApiAddress.updateIntroFlcer,
        method: 'post',
        isFormData: true,
        params: {
          "token": prefs.getString(StringConst.tokenKey),
          'skill_year': expYear,
          'user_des': intro,
        });
  }
}
