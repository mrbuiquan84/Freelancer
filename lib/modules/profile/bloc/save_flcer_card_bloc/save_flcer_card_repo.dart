import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

import '../../../../common/services/share_pref/pref_service.dart';
import '../../../../core/constants/string_constants.dart';

class SaveFlcerCardRepo {
  Future<ResultData> saveFlcer({required String flcerId}) async =>
      await httpManager.netFetch(ApiAddress.saveFlcer,
          isFormData: true,
          method: 'post',
          params: {
            'token': prefs.getString(StringConst.tokenKey),
            'flc_id': flcerId,
          });
  Future<ResultData> getsavedFlcer({int page = 1, int limit = 10}) async =>
      await httpManager.netFetch(ApiAddress.getSavedFlcer, queryPrams: {
        'token': prefs.getString(StringConst.tokenKey),
        'page': page,
        'limit': limit
      });
}
