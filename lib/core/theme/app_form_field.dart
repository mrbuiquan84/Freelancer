import 'package:flutter/material.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/app_padding.dart';

import 'app_text_styles.dart';

class AppFormField {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    hintStyle: AppTextStyles.hintTxtStyle,
    errorMaxLines: 2,
    contentPadding: AppPadding.formFieldContentPadding,
    enabledBorder: AppBorderAndRadius.outlineInputBorder,
    disabledBorder: AppBorderAndRadius.outlineInputDisabledBorder,
    focusedBorder: AppBorderAndRadius.outlineInputFocusedBorder,
    errorBorder: AppBorderAndRadius.outlineInputErrorBorder,
    focusedErrorBorder: AppBorderAndRadius.outlineInputErrorBorder,
    filled: true,
    fillColor: Colors.white,
  );

  static InputDecoration inputDecoration = InputDecoration(
    hintStyle: AppTextStyles.hintTxtStyle,
    hintMaxLines: 2,
    errorMaxLines: 2,
    helperMaxLines: 2,
    contentPadding: AppPadding.formFieldContentPadding,
    enabledBorder: AppBorderAndRadius.outlineInputBorder,
    disabledBorder: AppBorderAndRadius.outlineInputDisabledBorder,
    focusedBorder: AppBorderAndRadius.outlineInputFocusedBorder,
    errorBorder: AppBorderAndRadius.outlineInputErrorBorder,
    focusedErrorBorder: AppBorderAndRadius.outlineInputErrorBorder,
    filled: true,
    fillColor: Colors.white,
    isDense: true,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    prefixIconConstraints: const BoxConstraints(),
    suffixIconConstraints: const BoxConstraints(),
  );
}
