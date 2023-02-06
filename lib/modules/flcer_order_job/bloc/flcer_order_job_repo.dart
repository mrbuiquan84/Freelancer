import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class FlcerOrderJobRepo {
  Future<ResultData> orderJob({
    required int jobId,
    required String salary,
    required String email,
    required String expDate,
  }) async =>
      httpManager.netFetch(
        ApiAddress.postFlcerOrderJob,
        method: 'post',
        params: {
          'token': prefs.getString(StringConst.tokenKey),
          'job_id': jobId,
          'salary': salary,
          'flc_email': email,
          'day_bid_end': expDate,
        },
        isFormData: true,
      );
}
