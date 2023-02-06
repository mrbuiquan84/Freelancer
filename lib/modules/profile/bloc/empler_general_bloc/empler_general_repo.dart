import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/post_empler_general.dart';

import '../../../../common/services/http/code.dart';

class EmplerGeneralRepo {
  Future<ResultData> getEmplerGeneral() async {
    return await httpManager.netFetch(ApiAddress.emplerGeneral,
        params: {
          'token': prefs.getString(StringConst.tokenKey),
        },
        method: 'post',
        isFormData: true);
  }
}
