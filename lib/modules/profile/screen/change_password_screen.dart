import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/profile/change_password_bloc/change_password_bloc.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';

import '../../../utils/helpers/input_formatter.dart';
import '../../../utils/helpers/validators.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../change_password_bloc/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _reNewPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _rePasswordKey = GlobalKey<FormState>();

  late final ChangePassWordBloc _changePassword;
  @override
  void initState() {
    _changePassword = context.read<ChangePassWordBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _userType = CurrentUser.of(context).userType;
    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          StringConst.changePassword.toTitleCase(),
        ),
        centerTitle: true,
      ),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BlocListener(
          bloc: _changePassword,
          listener: (BuildContext context, state) {
            if (state is ChangePasswordSuccessState) {
              Navigator.of(context).maybePop();
            }
          },
          child: Column(
            children: [
              Image.asset(
                AppAsset.imgChangePassword,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 28.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
                child: Column(
                  children: [
                    AppTextField(
                      elevation: 0.0,
                      hint: StringConst.inputCurrentPassword,
                      isPassword: true,
                      controller: _currentPasswordController,
                    ),
                    AppTextField(
                      elevation: 0.0,
                      hint: StringConst.inputNewPassword,
                      isPassword: true,
                      controller: _newPasswordController,
                      formKey: _passwordKey,
                      validator: Validator.validatePassword,
                      inputFormatters: InputFormatter.passwordFormatter,
                    ),
                    AppTextField(
                        elevation: 0.0,
                        hint: StringConst.rePasswordLabel,
                        isPassword: true,
                        controller: _reNewPasswordController,
                        formKey: _rePasswordKey,
                        validator: (value) => Validator.validateNewPassword(
                              _newPasswordController.text,
                              value,
                            )),
                    SizedBox(
                      height: 45.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppOutlinedButton(
                            elevation: 0,
                            child: StringConst.cancel,
                            buttonPrimaryColor: AppColors.orangeAccent,
                            labelTextStyle: const TextStyle(
                              fontSize: 16.0,
                              height: 26.0 / 16.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.orangeAccent,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10.0,
                            ),
                            onPressed: () {
                              Navigator.of(context).maybePop();
                            },
                          ),
                          AppElevatedButton(
                            elevation: 0,
                            label: StringConst.changePassword,
                            labelTextStyle: const TextStyle(
                              fontSize: 16.0,
                              height: 26.0 / 16.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 10.0,
                            ),
                            onPressed: () {
                              if (_passwordKey.currentState!.validate() &&
                                  _rePasswordKey.currentState!.validate()) {
                                if (_userType == UserType.freelancer) {
                                  _changePassword.changePassword(
                                      password: _currentPasswordController.text,
                                      newpassword: _newPasswordController.text,
                                      newrepassword:
                                          _reNewPasswordController.text);
                                } else {
                                  _changePassword.changePassword2(
                                      password: _currentPasswordController.text,
                                      newpassword: _newPasswordController.text,
                                      newrepassword:
                                          _reNewPasswordController.text);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
