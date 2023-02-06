import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class OngoingProjectRepo {
  Future<ResultData> getOngoingProject({
    int page = 1,
    int limit = kFlcerOngoingProjectLimit,
  }) async =>
      await httpManager
          .netFetch(ApiAddress.getFlcerOngoingProject, queryPrams: {
        'token': prefs.getString(StringConst.tokenKey),
        'page': page,
        'limit': limit,
      });
}
