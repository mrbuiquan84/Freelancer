import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    Key? key,
    this.onPressed,
    this.elevation,
    this.borderRadius,
    this.buttonPrimaryColor,
    this.borderColor,
    this.labelColor,
    this.labelTextStyle,
    this.padding,
    this.height,
    this.width,
    this.backgroundColor,
    this.labelAlignment,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final dynamic child;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final Color? buttonPrimaryColor;
  final Color? borderColor;
  final Color? labelColor;
  final TextStyle? labelTextStyle;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final AlignmentGeometry? labelAlignment;

  @override
  Widget build(BuildContext context) {
    late final Widget buildChild;

    var labelStyle = labelTextStyle ??
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: labelColor ?? (buttonPrimaryColor ?? AppColors.primaryColor),
        );

    if (child is String) {
      var textLabel = Text(
        child as String,
        textHeightBehavior: const TextHeightBehavior(
          leadingDistribution: TextLeadingDistribution.even,
        ),
        maxLines: 1,
        style: labelStyle,
      );
      buildChild = labelAlignment != null
          ? Align(
              alignment: labelAlignment!,
              child: textLabel,
            )
          : textLabel;
    } else {
      buildChild = child as Widget;
    }

    var contentPadding = (padding ??
        const EdgeInsets.symmetric(
          vertical: kButtonLabelVerticalPadding,
          horizontal: kButtonHorizontalPadding,
        ));
    // :
    // EdgeInsets.symmetric(
    //     vertical: (height! -
    //             ((labelStyle.height ?? 1.0) * labelStyle.fontSize!)) /
    //         2,
    //     horizontal: padding?.horizontal ?? kButtonHorizontalPadding,
    //   );

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: buildChild,
        style: OutlinedButton.styleFrom(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(kBorderRadius),
          ),
          side: BorderSide(
            color: borderColor ?? buttonPrimaryColor ?? AppColors.primaryColor,
            width: 1,
          ),
          backgroundColor: backgroundColor,
          padding: contentPadding,
          shadowColor: AppColors.appShadowColor,
          minimumSize: Size.zero,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
