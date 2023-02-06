import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';

class ErrorActionWidget extends StatelessWidget {
  const ErrorActionWidget({
    Key? key,
    this.error,
    this.onPressed,
    this.buttonLabel,
  }) : super(key: key);
  final dynamic error;
  final VoidCallback? onPressed;
  final String? buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (error != null) Text(error!.toString()),
          AppElevatedButton(
            label: buttonLabel ?? StringConst.reload,
            labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
