import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/help_text_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/layout/unauth_page_layout.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_state.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/helpers/validators.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_load_dialog.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  late final ForgotPasswordBloc _forgotPasswordBloc;
  bool _isShowingDialog = false;

  @override
  void initState() {
    _forgotPasswordBloc = context.read<ForgotPasswordBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var timeCounter = 60;
    return UnAuthPageLayout(
      appBarTitle: StringConst.forgotPassword.toTitleCase(),
      child: BlocListener(
        bloc: _forgotPasswordBloc,
        listener: (_, state) {
          if (_isShowingDialog) {
            AppRouter.back(context);
            _isShowingDialog = false;
          }
          if (state is ForgotPasswordLoadState) {
            _isShowingDialog = true;
            showLoadDialog(context).then((value) => _isShowingDialog = false);
          } else if (state is ForgotPasswordErrorState) {
            showToast(state.error.toString());
          } else if (state is ForgotPasswordRecievedOTPState &&
              ModalRoute.of(context)?.settings.name !=
                  AppPages.forgotPasswordOtp.name) {
            AppRouter.toPage(
              context,
              AppPages.forgotPasswordOtp,
              blocValue: _forgotPasswordBloc,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                StringConst.askEmailToSendOTP,
                style: AppTextStyles.textStyle,
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: height * 0.07),
              // Padding(
              AppTextField(
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                hint: StringConst.askEmail,
                prefixIcon: AppAsset.icEmail1,
                formKey: _emailKey,
                validator: Validator.validateEmail,
                controller: _emailController,
              ),
              // ),
              AppElevatedButton(
                label: '${StringConst.confirm} (${timeCounter}S)',
                padding: const EdgeInsets.symmetric(
                  vertical: kButtonLabelVerticalPadding,
                  horizontal: 20.0,
                ),
                onPressed: () {
                  if (_emailKey.currentState!.validate()) {
                    _forgotPasswordBloc.sendOTP(email: _emailController.text);
                  }
                },
              ),
              HelpTextButton(
                header: StringConst.notReceivedCodeYet,
                label: StringConst.resendCode,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
