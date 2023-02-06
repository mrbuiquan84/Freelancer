import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/appbar/unauthenticated_appbar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:freelancer/modules/signup/bloc/signup_bloc.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/input_formatter.dart';
import 'package:freelancer/utils/helpers/validators.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/utils/ui/show_load_dialog.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthBloc _authBloc;
  late final AppRepo _appRepo;
  late final UserType _userType;

  bool _isShowingDialog = false;

  final TextEditingController _emailController = TextEditingController();
  //  ..text = 'mrbuiquan84@gmail.com';
  final TextEditingController _passwordController = TextEditingController();
  //  ..text = 'Quan123456';
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    _appRepo = context.read<AppRepo>();
    _userType = CurrentUser.of(context).userType;
  }

  @override
  Widget build(BuildContext context) {
    var textField = Column(
      children: [
        AppTextField(
          hint: StringConst.askEmail,
          padding: const EdgeInsets.only(top: kTextFieldBottomPadding),
          prefixIcon: AppAsset.icEmail1,
          controller: _emailController,
          formKey: _emailKey,
          validator: Validator.validateNotEmpty,
          height: 45,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          // inputFormatters: InputFormatter.emailFormatter,
        ),
        AppTextField(
          hint: StringConst.askPassword,
          padding: const EdgeInsets.only(top: kTextFieldBottomPadding),
          prefixIcon: AppAsset.icPassword1,
          height: 45,
          isPassword: true,
          controller: _passwordController,
          formKey: _passwordKey,
          validator: Validator.validateNotEmpty,
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (_) => _login(),
          inputFormatters: InputFormatter.passwordFormatter,
        ),
      ],
    );

    var forgotPasswordButton = Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          final forgotPasswordBloc = ForgotPasswordBloc();
          AppRouter.toPage(
            context,
            AppPages.forgotPassword,
            blocValue: forgotPasswordBloc,
          );
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          StringConst.forgotPassword,
          style: _buildTxtStyle(
            context,
            size: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: AppColors.hintColor,
          ),
        ),
      ),
    );

    var loginButton = AppElevatedButton(
      label: StringConst.login,
      onPressed: _login,
      width: double.infinity,
    );

    var _notHaveAccountText = Text(
      StringConst.notHaveAccount,
      style: _buildTxtStyle(
        context,
        size: 15,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
      ),
    );

    var _signUpNowText = Text(
      StringConst.signUpNow.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.visible,
      style: _buildTxtStyle(
        context,
        size: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: AppColors.orangeAccent,
      ),
    );

    var _signUpButton = TextButton(
      onPressed: () {
        //TODO: signup now here
        var signUpBloc = SignUpBloc(appRepo: _appRepo);
        onUserTypeCase(
          _userType,
          flcerFunc: () => AppRouter.toPage(
            context,
            AppPages.flcerSignUp,
            blocValue: signUpBloc,
          ),
          emplerFunc: () => AppRouter.toPage(
            context,
            AppPages.emplerSignup,
            blocValue: signUpBloc,
          ),
        );
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: _signUpNowText,
    );

    var signUpFooter = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _notHaveAccountText,
        Flexible(
          child: LayoutBuilder(
            builder: (context, constrain) {
              if (_signUpNowText.hasTextOverflow(
                maxWidth: constrain.maxWidth,
              )) {
                return FittedBox(child: _signUpButton);
              } else {
                return _signUpButton;
              }
            },
          ),
        ),
      ],
    );

    var loginLogo = AppAsset.imgFreelancerLogo;
    var appbarTitle = StringConst.flcerLogin;

    onUserTypeCase(_userType, emplerFunc: () {
      appbarTitle = StringConst.emplerLogin;
      loginLogo = AppAsset.imgRecruitmentLogo;
    });

    var unAuthAppBar = UnAuthAppBar(
      title: appbarTitle,
    );

    var center = Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            loginLogo,
            fit: BoxFit.cover,
            width: (MediaQuery.of(context).size.width * 0.2).clamp(0, 120),
          ),
          textField,
          forgotPasswordButton,
          loginButton,
          const SizedBox(height: 10),
          signUpFooter,
          SizedBox(height: unAuthAppBar.appbarHeight),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            unAuthAppBar,
            SliverFillRemaining(
              child: center,
            ),
          ],
        ),
      ),
    );
  }

  _buildTxtStyle(
    BuildContext context, {
    required double size,
    required FontStyle fontStyle,
    required FontWeight fontWeight,
    Color color = AppColors.textColor,
  }) {
    return TextStyle(
      fontSize: size,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
    );
  }

  void _login() async {
    _isShowingDialog = true;
    showLoadDialog(context);
    if (_emailKey.currentState!.validate() &&
        _passwordKey.currentState!.validate()) {
      var message = await _authBloc.login(
        email: _emailController.text,
        password: _passwordController.text,
        loginUserType: _userType,
      );
      if (message != null) {
        if (_isShowingDialog) {
          AppRouter.back(context);
        }
        showToast(message);
      }
      // onUserTypeCase(
      //   _userType,
      //   flcerFunc: () => AppRouter.replaceAllWithPage(
      //     context,
      //     AppPages.home,
      //   ),
      //   emplerFunc: () => AppRouter.replaceAllWithPage(
      //     context,
      //     AppPages.home,
      //   ),
      // );
    }
  }
}
