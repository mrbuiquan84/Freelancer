import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final String label;
  final Color? borderColor;
  final TextStyle? labelTextStyle;
  final double elevation;
  final Color? primary;
  final Color? onPrimary;
  final double? borderRadius;
  final double? height;

  const AppElevatedButton({
    Key? key,
    this.onPressed,
    this.padding,
    this.width,
    this.borderColor,
    this.labelTextStyle,
    this.elevation = kElevation,
    this.primary,
    this.onPrimary,
    this.borderRadius,
    this.height,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var labelStyle = labelTextStyle ?? AppTextStyles.buttonTxtStyle;

    var contentPadding = height == null
        ? (padding ??
            const EdgeInsets.symmetric(
              vertical: kButtonLabelVerticalPadding,
              horizontal: kButtonHorizontalPadding,
            ))
        : EdgeInsets.symmetric(
            vertical: (height! -
                    ((labelStyle.height ?? 1.0) * labelStyle.fontSize!)) /
                2,
            horizontal: padding?.horizontal ?? kButtonHorizontalPadding,
          );

    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? kBorderRadius),
        ),
        onPrimary: onPrimary ?? AppColors.primaryColor,
        primary: primary ?? AppColors.primaryColor,
        padding: contentPadding,
        shadowColor: Colors.black,
        elevation: elevation,
        minimumSize: Size.zero,
        alignment: Alignment.center,
      ),
      child: Text(
        label,
        style: labelStyle,
        textHeightBehavior: const TextHeightBehavior(
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
    );

    button = SizedBox(
      width: width,
      child: button,
    );

    return button;
  }
}
