import 'dart:convert';

import 'package:freelancer/common/services/http/code.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class Data {
  final bool result;
  final String message;
  final dynamic error;
  final dynamic data;

  Data({
    required this.result,
    required this.message,
    required this.data,
    required this.error,
  });

  static dataFromJson(String str) {
    try {
      var decoded = json.decode(str);
      var error = decoded['error'];
      var data = decoded['data'];
      dynamic jsonObj;
      var result = true;
      String message;
      if (error is! bool) {
        // has error
        result = false;
        jsonObj = error;
        data = null;
      } else {
        jsonObj = data;
        error = null;
      }
      message = jsonObj['message'] ??
          data['message'] ??
          error['message'] ??
          StringConst.errorOccurredTryAgainError;
      return Data(
        result: result,
        message: message,
        data: data,
        error: error,
      );
    } catch (e, s) {
      print(e);
      print(s.toString());
      var error = StringConst.errorOccurredTryAgainError;
      return Data(
        data: null,
        error: Error(
          code: Code.UNKNOWN,
          message: error,
        ),
        message: error,
        result: false,
      );
    }
  }
}
