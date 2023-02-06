import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freelancer/common/models/data.dart';
import 'package:freelancer/common/services/http/code.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class ResultData {
  dynamic data;
  bool result;
  String message;
  int? code;
  Error? error;

  ResultData({
    this.data,
    this.result = true,
    this.message = '',
    this.code,
    this.error,
  }) {
    // if (data.toString().contains("error") ||
    //     data.toString().contains('Error')) {
    //   setError(data.toString());
    // }
  }

  // void setError(String strResponse) {
  //   try {
  //     var res = json.decode(strResponse);
  //     error = res['error'] != null ? Error.fromJson(res["error"]) : null;
  //   } catch (e) {
  //     Error error = Error(code: 404, message: e.toString());
  //     this.error = error;
  //   }
  // }

  factory ResultData.fromResponse(Response res) {
    Data data = Data.dataFromJson(res.data.toString());
    var result = data.result;
    var code = Code.SUCCESS;
    var error = data.error != null ? Error.fromJson(data.error) : null;
    return ResultData(
      data: data.data,
      result: result,
      message: data.message,
      code: code,
      error: error,
    );
  }

  factory ResultData.fromError(res) {
    if (res is DioError) {
      String errorMessage = StringConst.unknownError;

      if (res.error is SocketException) {
        errorMessage = StringConst.checkInternetConnection;
      } else if (res.type == DioErrorType.connectTimeout) {
        errorMessage = StringConst.checkInternetConnection;
      }

      var error = Error(
        message: errorMessage,
      );

      return ResultData(
        result: false,
        code: Code.UNKNOWN,
        error: error,
      );
    } else {
      return ResultData(
        result: false,
        code: Code.UNKNOWN,
      );
    }
  }

  @override
  String toString() {
    dynamic _data;
    try {
      _data = json.decode(json.encode(data.toString()));
    } catch (_) {
      _data = data;
    }
    return 'ResultData:  \n\tdata: ' +
        _data +
        '\n\tresult: ' +
        result.toString() +
        '\n\tcode: ' +
        code.toString() +
        '\n\terror: ' +
        error.toString();
  }
}

class Error {
  Error({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) {
    var message = json["message"] as String?;
    if (message != null && message.contains('Token hết hạn')) {
      message = 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại';
    }
    return Error(
      code: json["code"],
      message: message,
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };

  @override
  String toString() {
    return 'Lỗi: ' + message.toString();
  }
}
