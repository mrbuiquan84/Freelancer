import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class EmplerProfileRepo {
  Future<ResultData> getEmplerProfile() async {
    return await httpManager.netFetch(ApiAddress.getEmplerInfo,
        isFormData: true,
        method: "Post",
        params: {
          'token': prefs.getString(StringConst.tokenKey),
        });
  }
}
