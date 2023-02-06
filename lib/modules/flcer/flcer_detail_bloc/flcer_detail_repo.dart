import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

class FlcerDetailRepo {
  Future<ResultData> getFlcerDetai({
    required String flcerId,
  }) async =>
      await httpManager
          .netFetch(ApiAddress.getFlcerDetail, method: 'get', queryPrams: {
        'flc_id': flcerId,
      });
}
