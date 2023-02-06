import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/layout/unauth_page_layout.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_state.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late final ForgotPasswordBloc _forgotPasswordBloc;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = context.read<ForgotPasswordBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return UnAuthPageLayout(
      appBarTitle: StringConst.updatePassword.toTitleCase(),
      child: BlocListener(
        bloc: _forgotPasswordBloc,
        listener: (BuildContext context, state) {
          if (state is ForgotPasswordSuccessState) {
            AppRouter.toPage(context, AppPages.updatePasswordSuccess);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAsset.icPadlock),
            SizedBox(height: height * 0.05),
            AppTextField(
              elevation: 0.0,
              hint: StringConst.askPassword,
              controller: _passwordController,
              isPassword: true,
            ),
            AppTextField(
              elevation: 0.0,
              hint: StringConst.askPassword,
              controller: _rePasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 40.0),
            AppElevatedButton(
              label: StringConst.update,
              onPressed: () {
                _forgotPasswordBloc.updatePassword(
                  newPassword: _passwordController.text,
                );
              },
            ),
            const SizedBox(height: kSizedBoxHeight),
          ],
        ),
      ),
    );
  }
}
