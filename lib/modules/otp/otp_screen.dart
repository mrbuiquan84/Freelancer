import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/help_text_button.dart';
import 'package:freelancer/common/widgets/layout/unauth_page_layout.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/helpers/validators.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.title,
    this.pinCodeLength = 6,
    this.onSubmitButtonPressed,
    this.onResendPressed,
  }) : super(key: key);
  final String title;
  final int pinCodeLength;
  final ValueChanged<String>? onSubmitButtonPressed;
  final VoidCallback? onResendPressed;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var timeCounter = 60;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var horizontalPadding = kPadding(context) * 3 / 2;
    var pinCodeSize = kPinCodeSize;
    var codeFieldPadding =
        (width - horizontalPadding * 2 - 6 * kPinCodeSize) / 5;
    if (codeFieldPadding <= 8.0) {
      pinCodeSize -= 8.0;
    }
    return UnAuthPageLayout(
      appBarTitle: StringConst.validateOTP,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.2,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle,
            ),
          ),
          const SizedBox(
            height: kSizedBoxHeight,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: PinCodeTextField(
              appContext: context,
              length: widget.pinCodeLength,
              onChanged: (value) {},
              controller: _pinCodeController,
              validator: (value) => Validator.otpValidator(value,
                  otpLength: widget.pinCodeLength),
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(kBorderRadius10),
                shape: PinCodeFieldShape.box,
                fieldHeight: pinCodeSize,
                fieldWidth: pinCodeSize,
                activeColor: AppColors.borderColor,
                inactiveColor: AppColors.borderColor,
              ),
            ),
          ),
          SizedBox(height: height * 50.0 / 667),
          AppElevatedButton(
            label: '${StringConst.confirm} (${timeCounter}S)',
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: kButtonLabelVerticalPadding,
              horizontal: 20.0,
            ),
            onPressed: () {
              if (widget.onSubmitButtonPressed != null) {
                widget.onSubmitButtonPressed!(_pinCodeController.text);
              }
              print(_pinCodeController.text);
            },
          ),
          HelpTextButton(
            header: StringConst.notReceivedCodeYet,
            label: StringConst.resendCode,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
