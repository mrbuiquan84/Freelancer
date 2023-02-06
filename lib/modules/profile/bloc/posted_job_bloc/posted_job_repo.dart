import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

import '../../../../common/services/share_pref/pref_service.dart';
import '../../../../core/constants/string_constants.dart';

class PostedJobRepo {
  Future<ResultData> getpostedJob({
    int page = 1,
    int limit = 10,
  }) async =>
      await httpManager.netFetch(ApiAddress.postedJob,
          isFormData: true,
          method: 'post',
          params: {
            'token': prefs.getString(StringConst.tokenKey),
            'page': page,
            'limit': limit,
          });
}
