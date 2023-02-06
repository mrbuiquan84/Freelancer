import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

import '../../../../common/services/share_pref/pref_service.dart';
import '../../../../core/constants/string_constants.dart';

class PostJobRepo {
  const PostJobRepo();

  Future<ResultData> postJob({
    MultipartFile? companyLogo,
    required String titleJob,
    required int categoryID,
    required int workType,
    required int workCity,
    required int workExp,
    required String workDes,
    MultipartFile? workFileDes,
    required List<int> skillId,
    required int salaryType,
    required String salaryNumber,
    required int salaryDate,
    required String startDay,
    required String endDay,
    required String startWorkDay,
    required int jobType,
    required int workingTerm,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    var body = {
      'title_job': titleJob,
      'company_logo': companyLogo,
      'category_id': categoryID,
      'work_type': workType,
      'work_city': workCity,
      'work_exp': workExp,
      'work_des': workExp,
      'work_file_des': workFileDes,
      'skill_id': skillId,
      'salary_type': salaryType,
      'salary_permanent_number': salaryNumber,
      'salary_permanent_date': salaryDate,
      'date_bid_start': startDay,
      'date_bid_end': endDay,
      'date_work_start': startWorkDay,
      'token': prefs.getString(StringConst.tokenKey),
      'job_type': jobType,
      'working_term': workingTerm,
    };
    return await httpManager.netFetch(ApiAddress.postJob,
        method: 'post', params: body, isFormData: true);
  }
}
