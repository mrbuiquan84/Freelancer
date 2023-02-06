import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
    Key? key,
    this.labelTextStyle,
    this.isRequired = false,
    this.padding,
    required this.label,
  }) : super(key: key);
  final String label;
  final TextStyle? labelTextStyle;
  final bool isRequired;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var _label = Padding(
      padding: padding ??
          const EdgeInsets.only(bottom: kTextFieldLabelBottomPadding),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: labelTextStyle ?? AppTextStyles.hintTxtStyle,
              children: [
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: AppTextStyles.hintTxtStyle.apply(
                      color: AppColors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    return _label;
  }
}
