import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../common/services/share_pref/pref_service.dart';
import '../../../core/constants/string_constants.dart';

class EmplerHomeRepo {
  Future<ResultData> loadData({
    int page = 1,
    int limit = 10,
    // int type = 2,
  }) async =>
      await httpManager.netFetch(ApiAddress.getEmplerHomeData, queryPrams: {
        'page': page,
        'limit': limit,
        'token': prefs.getString(StringConst.tokenKey),
      });
}
