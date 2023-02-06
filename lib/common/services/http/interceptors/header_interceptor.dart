import 'package:dio/dio.dart';

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    options.connectTimeout = 10000;
    options.receiveTimeout = 10000;
  }

// @override
// onRequest(RequestOptions options) async {
//   options.connectTimeout = 10000;
//   options.receiveTimeout = 10000;
//   return options;
// }
}