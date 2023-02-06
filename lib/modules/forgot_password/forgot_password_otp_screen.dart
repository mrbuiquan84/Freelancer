import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_state.dart';
import 'package:freelancer/modules/otp/otp_screen.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';

class ForgotPasswordOTPScreen extends StatelessWidget {
  const ForgotPasswordOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _forgotPasswordBloc = context.read<ForgotPasswordBloc>();

    return BlocListener(
      bloc: _forgotPasswordBloc,
      listener: (_, state) {
        if (state is ForgotPasswordConfirmedOTPState) {
          AppRouter.toPage(
            context,
            AppPages.updatePassword,
            blocValue: _forgotPasswordBloc,
          );
        }
      },
      child: OTPScreen(
        title: StringConst.sendOTPNotif,
        onSubmitButtonPressed: (value) {
          _forgotPasswordBloc.checkOTP(otp: value);
        },
      ),
    );
  }
}
