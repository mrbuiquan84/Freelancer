import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppThemes {
  static const appBarActionIconTheme = IconThemeData(
    color: AppColors.iconColor,
  );

  static final themeData = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: AppConst.fontNunito,
    shadowColor: AppColors.appShadowColor,
    textTheme: const TextTheme()
      ..apply(
        bodyColor: AppColors.textColor,
        displayColor: AppColors.textColor,
        fontFamily: AppConst.fontNunito,
      ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColors.primaryColor,
      color: AppColors.backgroundColor,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightIrisBlue,
      disabledColor: AppColors.lightIrisBlue,
      selectedColor: AppColors.primaryColor,
      secondarySelectedColor: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(
        vertical: kChipVerticalPadding,
        horizontal: kChipHorizontalPadding,
      ),
      labelStyle: AppTextStyles.chipTextStyle,
      secondaryLabelStyle: AppTextStyles.chipTextStyle.copyWith(
        color: AppColors.white,
      ),
      brightness: Brightness.light,
    ),
  );
}
