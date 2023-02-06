import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_bar_back_button.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_theme.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  AppAppBar({
    Key? key,
    this.toolbarHeight,
    this.bottomHeight,
    this.leading,
    this.title,
    this.elevation = kElevation,
    this.bottom,
    this.actions,
    this.flexibleSpace,
    this.shape,
    this.extraHeight,
    this.centerTitle = false,
    this.leadingWidth,
    this.backButtonAsLeading = true,
  })  : preferredSize = Size.fromHeight((toolbarHeight ?? kToolbarHeight) +
            (bottom?.preferredSize.height ?? 0.0) +
            (extraHeight ?? 0)),
        super(key: key);

  @override
  final Size preferredSize;

  final double? toolbarHeight;
  final Widget? flexibleSpace;
  final double? bottomHeight;
  final Widget? leading;
  final Widget? title;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final bool centerTitle;
  final ShapeBorder? shape;
  final double? extraHeight;
  final double? leadingWidth;
  final bool backButtonAsLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButtonAsLeading ? (leading ?? const AppBackButton()) : null,
      title: title,
      titleTextStyle: AppTextStyles.appbarTitleTxtStyle,
      leadingWidth: leadingWidth,
      elevation: elevation,
      bottom: bottom,
      actions: actions,
      actionsIconTheme: AppThemes.appBarActionIconTheme,
      backgroundColor: AppColors.backgroundColor,
      centerTitle: centerTitle,
      shadowColor: AppColors.appShadowColor,
      shape: shape ?? AppBorderAndRadius.defaultAppBarBorder,
      flexibleSpace: flexibleSpace,
      toolbarHeight: toolbarHeight,
    );
  }
}
