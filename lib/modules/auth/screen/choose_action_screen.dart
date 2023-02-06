import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/widget/appbar_with_logo.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/signup/bloc/signup_bloc.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/flcer/bloc/flcer_home_bloc.dart';

class ChooseActionScreen extends StatelessWidget {
  const ChooseActionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = kPadding(context) * 2;
    var appBar = AppBarWithLogo(
      showBackButton: true,
    );

    final appRepo = context.read<AppRepo>();
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppOutlinedButton(
                height: 45.0,
                width: double.infinity,
                child: StringConst.login,
                onPressed: () {
                  // var userType = CurrentUser.of(context).userType;
                  AppRouter.toPage(
                    context,
                    AppPages.login,
                    blocValue: authBloc,
                  );
                },
              ),
              const SizedBox(
                height: kSizedBoxHeight,
              ),
              AppOutlinedButton(
                height: 45.0,
                width: double.infinity,
                child: StringConst.createAccount,
                onPressed: () {
                  var userType = CurrentUser.of(context).userType;
                  var signupBloc = SignUpBloc(appRepo: appRepo);
                  onUserTypeCase(
                    userType,
                    flcerFunc: () => AppRouter.toPage(
                      context,
                      AppPages.flcerSignUp,
                      blocValue: signupBloc,
                    ),
                    emplerFunc: () => AppRouter.toPage(
                      context,
                      AppPages.emplerSignup,
                      blocValue: signupBloc,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: kSizedBoxHeight,
              ),
              AppOutlinedButton(
                height: 45.0,
                width: double.infinity,
                child: StringConst.loginWithoutAccount,
                onPressed: () {
                  var userType = CurrentUser.of(context).userType;
                  onUserTypeCase(
                    userType,
                    flcerFunc: () => AppRouter.toPage(
                      context,
                      AppPages.nonFlcer,
                      blocValue: FlcerHomeBloc(),
                    ),
                    emplerFunc: () => AppRouter.toPage(
                      context,
                      AppPages.home,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: kSizedBoxHeight,
              ),
              // Expanded(child: SizedBox(height: appBarHeight)),
            ],
          ),
        ),
      ),
    );
  }
}
