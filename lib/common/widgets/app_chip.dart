import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    Key? key,
    required this.label,
    this.primary,
    this.labelPadding,
    this.labelTextStyle,
    this.borderRadius,
    this.onTap,
    this.padding,
    this.trailing,
  }) : super(key: key);

  final String label;
  final double? borderRadius;
  final Color? primary;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? labelTextStyle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    var text = Text(
      label,
      style: AppTextStyles.normalTextStyle(
        height: 21.82,
      ),
    );
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: padding ??
            const EdgeInsets.symmetric(
              horizontal: 5.0 / 2,
            ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(borderRadius ?? kBorderRadius10),
        ),
        padding: labelPadding ??
            const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 3.0,
            ),
        child: trailing == null
            ? text
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  text,
                  trailing!,
                ],
              ),
      ),
    );
  }
}
