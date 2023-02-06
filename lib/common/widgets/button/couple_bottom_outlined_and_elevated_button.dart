import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class CoupleBottomOutlinedAndElevatedButtons extends StatelessWidget {
  const CoupleBottomOutlinedAndElevatedButtons({
    Key? key,
    required this.firstLabel,
    required this.secondaryLabel,
    this.labelTextStyle,
    this.onPressedFirstButton,
    this.onPressedSecondaryButton,
    this.boxDecoration,
    this.padding,
    this.margin,
    this.height,
    this.buttonLabelPadding,
    this.buttonRadius,
  }) : super(key: key);

  final TextStyle? labelTextStyle;
  final String firstLabel;
  final String secondaryLabel;
  final VoidCallback? onPressedFirstButton;
  final VoidCallback? onPressedSecondaryButton;
  final BoxDecoration? boxDecoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final EdgeInsetsGeometry? buttonLabelPadding;
  final double? buttonRadius;

  @override
  Widget build(BuildContext context) {
    final textStyle = labelTextStyle ??
        const TextStyle(
          fontFamily: AppConst.fontNunito,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          height: 24.0 / 16.0,
        );
    return Container(
      height: height ?? 64,
      margin: margin,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: kPadding(context) * 2,
            // vertical: 12.0,
          ),
      color: boxDecoration == null ? AppColors.white : null,
      decoration: boxDecoration,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: AppOutlinedButton(
              child: firstLabel,
              height: height,
              width: double.infinity,
              buttonPrimaryColor: AppColors.orangeAccent,
              labelTextStyle: textStyle.copyWith(color: AppColors.orangeAccent),
              onPressed: onPressedFirstButton,
              padding: buttonLabelPadding,
              borderRadius: buttonRadius != null
                  ? BorderRadius.circular(buttonRadius!)
                  : null,
            ),
          ),
          const SizedBox(width: kSizedBoxWidth),
          Expanded(
            flex: 1,
            child: AppElevatedButton(
              label: secondaryLabel,
              height: height,
              width: double.infinity,
              labelTextStyle: textStyle.copyWith(
                color: AppColors.white,
              ),
              elevation: 0.0,
              onPressed: onPressedSecondaryButton,
              padding: buttonLabelPadding,
              borderRadius: buttonRadius,
            ),
          ),
        ],
      ),
    );
  }
}
