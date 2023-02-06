import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/otp/otp_screen.dart';
import 'package:freelancer/modules/signup/bloc/signup_bloc.dart';
import 'package:freelancer/modules/signup/bloc/signup_state.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';

class SignupOTPScreen extends StatelessWidget {
  const SignupOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _signupBloc = context.read<SignUpBloc>();

    String _token = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)[StringConst.tokenKey];

    return BlocListener(
      bloc: _signupBloc,
      listener: (_, state) {
        if (state is SignupReceivedOTPState) {
          _token = state.token;
        } else if (state is SignupSuccessState) {
          AppRouter.replaceAllWithPage(
            context,
            AppPages.signupSuccess,
            predicate: (route) =>
                route.settings.name == AppPages.chooseAction.name,
          );
        }
      },
      child: OTPScreen(
        title: StringConst.sendOTPCodeToRecruitmentNotif,
        onSubmitButtonPressed: (otp) {
          _signupBloc.activeFlcer(otp: otp, token: _token);
        },
      ),
    );
  }
}
