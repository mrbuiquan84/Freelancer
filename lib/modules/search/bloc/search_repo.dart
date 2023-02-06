import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/search/models/search_input_model.dart';

class SearchRepo {
  Future<ResultData> searchJob({
    required SearchInputModel input,
  }) async {
    var token = prefs.getString(StringConst.tokenKey);
    var queryParams = input.toJson();
    queryParams['token'] = token;
    return await httpManager.netFetch(
      ApiAddress.getFilterJob,
      method: 'get',
      queryPrams: queryParams,
    );
  }
}
