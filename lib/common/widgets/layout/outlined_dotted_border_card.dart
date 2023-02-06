import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class OutlinedDottedBorderCard extends StatelessWidget {
  const OutlinedDottedBorderCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(15.0),
    this.elevation = kElevation,
    this.width,
    this.shadowColor,
    this.radius = kBorderRadius20,
    this.borderColor,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double? width;
  final Color? shadowColor;
  final double radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Align(
        child: Card(
          elevation: elevation,
          shadowColor: shadowColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: DottedBorder(
            color: borderColor ?? AppColors.primaryColor,
            radius: Radius.circular(radius),
            borderType: BorderType.RRect,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
