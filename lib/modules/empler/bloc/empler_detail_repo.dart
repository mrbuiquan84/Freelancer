import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class EmplerDetailRepo {
  Future<ResultData> getEmplerDetail({required int id}) async => await httpManager.netFetch(
        ApiAddress.postSeenDetailEmpler,
        isFormData: true,
        method: 'post',
        params: {
          'id': id,
          'token': prefs.getString(StringConst.tokenKey),
        },
      );
}
