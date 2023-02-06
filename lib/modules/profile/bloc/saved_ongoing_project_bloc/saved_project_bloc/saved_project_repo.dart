import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SavedProjectRepo {
  Future<ResultData> getFlcerSavedProject({
    int page = 1,
    int limit = kFlcerSavedProjectLimit,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.getFlcerSavedProject,
        queryPrams: {
          'token': prefs.getString(StringConst.tokenKey),
          'page': page,
          'limit': limit,
        },
      );

  Future<ResultData> deleteSavedProject({required String jobId}) async =>
      await httpManager.netFetch(
        ApiAddress.postFlcerSavedProject,
        params: {
          'token': prefs.getString(StringConst.tokenKey),
          'id_job': jobId,
        },
        isFormData: true,
        method: 'post',
      );

  Future<ResultData> saveProject({required String jobId}) async =>
      await httpManager.netFetch(
        ApiAddress.postFlcerSaveJob,
        params: {
          'token': prefs.getString(StringConst.tokenKey),
          'job_id': jobId,
        },
        isFormData: true,
        method: 'post',
      );
}
