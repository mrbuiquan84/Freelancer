import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/search/models/search_flcer_input_model.dart';

import '../../../common/services/share_pref/pref_service.dart';

class SearchFlcerRepo {
  Future<ResultData> searchFlcer({
    required SearchFlcerInputModel input,
  }) async {
    var token = prefs.getString(StringConst.tokenKey);
    var queryParams = input.toJson();
    queryParams['token'] = token;
    return await httpManager.netFetch(
      ApiAddress.getEmplerHomeData,
      method: 'get',
      queryPrams: queryParams,
    );
  }
}
