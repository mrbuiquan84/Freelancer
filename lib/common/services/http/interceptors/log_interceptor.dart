// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';

class LogsInterceptor extends InterceptorsWrapper {
  static List<Map> sHttpResponses = [];
  static List<String> sResponsesHttpUrl = [];

  static List<Map<String, dynamic>> sHttpRequest = [];
  static List<String> sRequestHttpUrl = [];

  static List<Map<String, dynamic>> sHttpError = [];

  static List<String> sHttpErrorUrl = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    var data = options.data;
    var body = data;

    if (data is FormData) {
      body = <String, dynamic>{};
      // print(data.fields);
      for (var e in data.fields) {
        (body as Map<String, dynamic>).putIfAbsent(e.key, () => e.value);
      }
    }
    print(
        "URL: ${options.path} \nMethod: ${options.method} \nheader: ${options.headers} \nparams: ${options.queryParameters} \nbody/query: $body");

    try {
      addLogic(sRequestHttpUrl, options.path);

      var data = options.data ?? <String, dynamic>{};

      var map = {
        "header": {...options.headers},
      };

      if (options.method == "POST") map["data"] = options.data;

      addLogic(sHttpRequest, data);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    print('Error: ' + err.toString());
    print('Error response: ' + (err.response?.toString() ?? ""));

    try {
      addLogic(sHttpErrorUrl, err.requestOptions.path);
      var errors = <String, dynamic>{};
      errors["error"] = err.message;
      addLogic(sHttpError, errors);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    print('Response: ${response.requestOptions.path}\n' + response.toString());

    var data;
    try {
      if (response.data is Map ||
          response.data is List ||
          response.data is String) {
        data = <String, dynamic>{};
        data["data"] = response.data;
      } else if (response.data != null) {
        data = response.data.toRecruiterJson(); // type String
      }
    } catch (e) {
      print(e);
    }

    addLogic(
      sResponsesHttpUrl,
      response.requestOptions.uri.toString(),
    );
    addLogic(sHttpResponses, data);
  }

  static addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }

    list.add(data);
  }
}
