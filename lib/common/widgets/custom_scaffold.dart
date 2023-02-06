import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/app_padding.dart';

import 'bottom_container.dart';
import 'button/app_bar_back_button.dart';

class CustomScaffold extends StatelessWidget {
  final bool shouldHandleBackButtonPress;
  final String title;
  final bool showBackBtn;
  final PreferredSizeWidget? bottomAppBar;
  final bool extendBodyBehindAppBar;
  final bool extendBody;
  final Widget body;
  final Widget? bottomNavigationBar;
  final void Function()? onBackBtnPressed;
  final List<Widget>? bottomContainerChildren;
  final bool hasRadius;
  final double? elevation;
  final Color? backgroundColor;

  const CustomScaffold({
    Key? key,
    this.shouldHandleBackButtonPress = false,
    required this.title,
    this.showBackBtn = true,
    this.bottomAppBar,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    required this.body,
    this.bottomNavigationBar,
    this.onBackBtnPressed,
    this.bottomContainerChildren,
    this.hasRadius = false,
    this.elevation = 4,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = AppPadding.defaultAppBarHeight +
        (bottomAppBar != null ? bottomAppBar!.preferredSize.height : 0);

    Widget current = Scaffold(
      appBar: AppBar(
        toolbarHeight: height,
        backgroundColor: Colors.white,
        leading: showBackBtn == false
            ? null
            : AppBackButton(onPressed: onBackBtnPressed),
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyles.appbarTitleTxtStyle,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: bottomAppBar,
        shape: AppBorderAndRadius.defaultAppBarBorder,
        elevation: elevation,
        shadowColor: AppColors.appShadowColor,
      ),
      // backgroundColor: AppColors.white,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      body: Padding(
        padding: extendBodyBehindAppBar
            ? EdgeInsets.only(
                top: bottomAppBar == null
                    ? 5
                    : bottomAppBar!.preferredSize.height + 30,
                bottom: extendBody ? 70 : 0,
              )
            : const EdgeInsets.all(0),
        child: body,
      ),
      bottomNavigationBar: bottomContainerChildren == null ||
              bottomContainerChildren?.isEmpty == true
          ? null
          : BottomContainer(
              children: bottomContainerChildren,
            ),
    );
    return current;
  }
}
