import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class UpdateExpectedJobRepo {
  const UpdateExpectedJobRepo();

  Future<ResultData> updateExpectedJobRepo({
    required String userJob,
    required int formWork,
    required int workDesire,
    required int workPlace,
    required int salaryTpye,
    required int salaryDate,
    required int salaryPermanent,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    return await httpManager.netFetch(ApiAddress.updateExpectedJobFlcer,
        method: 'post',
        isFormData: true,
        params: {
          "token": prefs.getString(StringConst.tokenKey),
          "user_job": userJob,
          "form_of_work": formWork,
          "work_desire": workDesire,
          "work_place": workPlace,
          "salary_type": salaryTpye,
          "salary_estimates_date": salaryDate,
          "salary_permanent_number": salaryPermanent,
        });
  }
}
