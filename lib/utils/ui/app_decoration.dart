import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

import 'app_border_and_radius.dart';

class AppDecoration {
  static ui.Gradient getIconGradientShader(Size size) => ui.Gradient.linear(
        Offset(size.width * 7.443397e-7, size.height * 0.4972973),
        Offset(size.width, size.height * 0.4972973),
        const [Color(0xff4C5BD4), Color(0xff978ECF)],
        const [0, 1],
      );

  static final defaultShadow = [
    const BoxShadow(
      offset: Offset(0, 3),
      blurRadius: 4,
      color: AppColors.shadow20,
    )
  ];

  static final BoxDecoration cardBoxDecoration = BoxDecoration(
    color: Colors.white,
    border: AppBorderAndRadius.uniformBorder,
    boxShadow: defaultShadow,
  );
}
