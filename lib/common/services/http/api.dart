import 'dart:collection';

import 'package:dio/dio.dart';

import 'interceptors/error_interceptor.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'result_data.dart';

class HttpManager {
  final Dio _dio = Dio();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptor());

    _dio.interceptors.add(LogsInterceptor());

    _dio.interceptors.add(ErrorInterceptor(_dio));

    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<ResultData> netFetch(
    url, {
    Options? option,
    params,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryPrams,
    noTip = false,
    isFormData = false,
    String method = "get",
  }) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (isFormData) {
      // headers['Content-type'] = 'multipart/form-data';
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: method);
      option.headers = headers;
    }

    var data = isFormData ? FormData.fromMap(params) : params;

    Response? response;

    try {
      response = await _dio.request(
        url,
        data: data,
        queryParameters: queryPrams,
        options: option,
      );
    } catch (e) {
      return ResultData.fromError(e);
    }

    return ResultData.fromResponse(response);
  }
}

final HttpManager httpManager = HttpManager();
