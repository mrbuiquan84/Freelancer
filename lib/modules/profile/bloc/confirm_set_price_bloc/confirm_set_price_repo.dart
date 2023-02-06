import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class ConfirmSetPriceRepo {
  Future<ResultData> confirmSetPriceRepo({
    required int isconfirm,
    required int jobId,
    required int flcID,
  }) async =>
      await httpManager.netFetch(ApiAddress.confirmSetPrice,
          isFormData: true,
          method: 'post',
          params: {
            'token': prefs.getString(StringConst.tokenKey),
            'isconfirm': isconfirm,
            'job_id': jobId,
            'flc_id': flcID
          });
}
