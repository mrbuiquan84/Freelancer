import 'package:dio/dio.dart';

Future<bool> checkImgUrl(String url) async {
  bool? parsedUrl = Uri.tryParse(url)?.isAbsolute;
  if (parsedUrl == null || !parsedUrl) {
    return false;
  } else {
    try {
      Response response = await Dio(
        BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 2000,
          sendTimeout: 3000,
        ),
      ).get(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
