import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class AppBorderAndRadius {
  static Border uniformBorder = const Border.fromBorderSide(BorderSide(
    color: AppColors.primaryColor,
    width: 1,
  ));

  static const Radius defaultRadius = Radius.circular(30);

  static const Radius formRadius = Radius.circular(10);

  static const Radius multilineFormRadius = Radius.circular(20);

  // static const Border defaultBorder = Border.all(color: AppColors.lightGray, width: 0.5);

  static const BorderRadius defaultBorderRadius =
      BorderRadius.all(defaultRadius);

  static const BorderRadius formBorderRadius = BorderRadius.all(formRadius);

  static const BorderRadius multilineFormBorderRadius =
      BorderRadius.all(multilineFormRadius);

  static RoundedRectangleBorder roundedRectangleBorder =
      const RoundedRectangleBorder(borderRadius: defaultBorderRadius);

  static OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.inactiveColor, width: 1),
    borderRadius: formBorderRadius,
  );

  static OutlineInputBorder outlineInputDisabledBorder =
      const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.inactiveColor),
    borderRadius: formBorderRadius,
  );

  static OutlineInputBorder outlineInputFocusedBorder =
      const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor),
    borderRadius: formBorderRadius,
  );

  static const OutlineInputBorder outlineInputErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.errorColor),
    borderRadius: formBorderRadius,
  );

  static RoundedRectangleBorder defaultAppBarBorder =
      const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
  );
}
