import 'package:bloc/bloc.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_repo.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_state.dart';
import 'package:freelancer/modules/forgot_password/model/post_get_forgot_password_otp_result.dart';

class ForgotPasswordBloc extends Cubit<ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitState());
  final ForgotPasswordRepo _repo = ForgotPasswordRepo();

  sendOTP({
    required String email,
  }) async {
    emit(ForgotPasswordLoadState());
    var res = await _repo.sendOTP(email: email);
    if (res.result) {
      var otpResult = PostGetForgotPasswordOTPResult.fromJson(res.data);
      _repo.token = otpResult.token;
      emit(ForgotPasswordRecievedOTPState(token: otpResult.token));
    } else {
      emit(ForgotPasswordErrorState(res.error?.message));
    }
  }

  checkOTP({
    required String otp,
  }) async {
    emit(ForgotPasswordLoadState());
    var res = await _repo.checkOTP(otp: otp);
    if (res.result) {
      var otpResult = PostGetForgotPasswordOTPResult.fromJson(res.data);
      _repo.token = otpResult.token;
      emit(ForgotPasswordConfirmedOTPState());
    } else {
      emit(ForgotPasswordErrorState(res._error?.message));
    }
  }

  updatePassword({
    required String newPassword,
  }) async {
    emit(ForgotPasswordLoadState());
    var res = await _repo.updatePassword(newPassword: newPassword);
    if (res.result) {
      emit(ForgotPasswordSuccessState());
    } else {
      emit(ForgotPasswordErrorState(res._error?.message));
    }
  }
}
