import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({
    Key? key,
    this.error,
    this.buttonLabel,
    this.onPressed,
  }) : super(key: key);

  final dynamic error;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container();
    if (error is String) {
      errorWidget = Text(
        error,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        errorWidget,
        AppElevatedButton(
          label: buttonLabel ?? StringConst.reload,
          height: 40.0,
          onPressed: onPressed,
          labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
        ),
      ],
    );
  }
}
