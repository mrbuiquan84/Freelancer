import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

import '../../../../common/services/share_pref/pref_service.dart';
import '../../../../core/constants/string_constants.dart';

class VoteFlcerRepo {
  Future<ResultData> voteFlcerRepo({
    required String flcerId,
    required String jobId,
    required int star,
  }) async =>
      await httpManager.netFetch(ApiAddress.voteFlcer,
          method: 'post',
          isFormData: true,
          params: {
            'token': prefs.getString(StringConst.tokenKey),
            'flc_id': flcerId,
            'job_id': jobId,
            'star': star
          });
}
