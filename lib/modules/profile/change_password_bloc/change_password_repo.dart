import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';

import '../../../common/services/share_pref/pref_service.dart';
import '../../../core/constants/string_constants.dart';

class ChangePassWordRepo {
  changePassword({
    required String password,
    required String newPassword,
    required String newrePassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return await httpManager.netFetch(ApiAddress.changePassword,
        isFormData: true,
        method: 'post',
        params: {
          'token': prefs.getString(StringConst.tokenKey),
          'password': password,
          'newpassword': newPassword,
          'newrepassword': newrePassword,
        });
  }

  changePassword2({
    required String password,
    required String newPassword,
    required String newrePassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return await httpManager.netFetch(ApiAddress.changePassword2,
        isFormData: true,
        method: 'post',
        params: {
          'token': prefs.getString(StringConst.tokenKey),
          'password': password,
          'newpassword': newPassword,
          'newrepassword': newrePassword,
        });
  }
}
