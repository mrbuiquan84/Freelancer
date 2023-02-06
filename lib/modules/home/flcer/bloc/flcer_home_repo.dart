import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class FlcerHomeRepo {
  Future<ResultData> loadData({
    int page = 1,
    int limit = kHomeItemLimit,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.getHomeLoadData,
        queryPrams: {
          'page': page,
          'limit': limit,
          'token': prefs.getString(StringConst.tokenKey),
        },
      );
  Future<ResultData> loadData2({
    int page = 1,
    int limit = kHomeItemLimit,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.getHomeLoadData,
        queryPrams: {
          'page': page,
          'limit': limit,
        },
      );
}
