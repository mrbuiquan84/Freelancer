import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class PriceProjectRepo {
  Future<ResultData> getPriceProject({
    int page = 1,
    int limit = kFlcerPriceProjectLimit,
  }) async =>
      await httpManager.netFetch(ApiAddress.getFlcerProjectPrice,
          params: {
            'token': prefs.getString(StringConst.tokenKey),
            'page': page,
            'limit': limit,
          },
          method: 'post',
          isFormData: true);

// Future<ResultData> priceProject({required String jobId}) async =>
}
