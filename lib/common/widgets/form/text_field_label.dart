import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_padding.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel(
    this.data, {
    Key? key,
    this.isRequire = false,
    this.autoMarginTop = true,
  }) : super(key: key);

  final String data;
  final bool isRequire;
  final bool autoMarginTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.paddingAll10.copyWith(
        top: autoMarginTop ? null : 0,
        left: 0,
      ),
      child: isRequire
          ? Text.rich(
              TextSpan(
                style: AppTextStyles.textFieldLabelTxtStyle,
                children: [
                  TextSpan(
                      text: data, style: AppTextStyles.textFieldLabelTxtStyle),
                  TextSpan(
                    text: ' *',
                    style: AppTextStyles.textFieldLabelTxtStyle.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          : Text(data, style: AppTextStyles.textFieldLabelTxtStyle),
    );
  }
}
