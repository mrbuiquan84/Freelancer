import 'package:freelancer/common/services/http/api.dart';
import 'package:freelancer/common/services/http/api_address.dart';
import 'package:freelancer/common/services/http/result_data.dart';

class ForgotPasswordRepo {
  String? token;

  Future<ResultData> sendOTP({
    required String email,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.postGetForgotPasswordOTP,
        isFormData: true,
        params: {
          'email': email,
        },
        method: 'post',
      );

  checkOTP({
    required String otp,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.postCheckForgotPasswordOTP,
        params: {
          'token': token,
          'otp': otp,
        },
        isFormData: true,
        method: 'post',
      );

  updatePassword({
    required String newPassword,
  }) async =>
      await httpManager.netFetch(
        ApiAddress.postUpdateNewPassword,
        params: {
          'password': newPassword,
          'token': token,
        },
        isFormData: true,
        method: 'post',
      );
}
