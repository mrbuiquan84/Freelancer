import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

class JobDetailRepo {
  Future<ResultData> getJobDetail({
    required String jobId,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.postDetailJob,
        method: 'post',
        isFormData: true,
        params: {
          'id': jobId,
        },
      );
}
