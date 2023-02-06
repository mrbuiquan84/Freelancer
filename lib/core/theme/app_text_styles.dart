import 'package:freelancer/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle appbarTitleTxtStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: AppColors.mineShaft,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 28.0 / 20,
  );

  static TextStyle hintTxtStyle =
      inputTextStyle.copyWith(color: AppColors.hintColor);

  static const TextStyle buttonTxtStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 26 / 18,
  );

  static const TextStyle buttonNormalTxtStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: AppColors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    height: 21.82 / 18,
  );

  static const TextStyle bottomNavButtonTxtStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle textFieldLabelTxtStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: AppColors.formFieldLabelColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: AppColors.textColor,
    fontSize: 18,
    height: 27 / 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: AppColors.mineShaft,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 28.19 / 16,
  );

  static TextStyle normalTextStyle({
    double height = 25.99,
    Color color = AppColors.textColor,
  }) =>
      TextStyle(
        fontFamily: AppConst.fontNunito,
        color: color,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: height / 16.0,
      );

  static const TextStyle cateHeaderStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    color: AppColors.darkBlue,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 28.0 / 18.0,
  );

  static const TextStyle iconWithTextTextStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 14.0,
    height: 19.1 / 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static const TextStyle chipTextStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 16.0 / 14.0,
    color: AppColors.textColor,
  );

  static const TextStyle tabLabelTextStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 24.0 / 16.0,
    color: AppColors.primaryColor,
  );

  static const TextStyle radioTextStyle = TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 16,
    height: 26 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.borderColor,
  );
}
