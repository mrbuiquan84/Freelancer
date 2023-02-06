import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class RefreshJobRepo {
  Future<ResultData> refreshJob({
    required int jobId,
  }) async =>
      await httpManager.netFetch(ApiAddress.refreshJob,
          isFormData: true,
          params: {
            'token': prefs.getString(StringConst.tokenKey),
            'id_job': jobId,
          },
          method: 'post');
}
