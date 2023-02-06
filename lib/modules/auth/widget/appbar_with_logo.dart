import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_bar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppBarWithLogo extends StatelessWidget with PreferredSizeWidget {
  AppBarWithLogo({
    Key? key,
    this.height = 100.0,
    this.showBackButton = false,
  })  : _toolbarHeight = height + kIconSize + kIconButtonPadding,
        super(key: key);

  final bool showBackButton;
  final double height;

  final double _toolbarHeight;

  double get appBarHeight => _toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      leading: Align(
        alignment: Alignment.bottomLeft,
        child: showBackButton ? const AppBackButton() : const SizedBox.shrink(),
      ),
      toolbarHeight: _toolbarHeight,
      elevation: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Image.asset(AppAsset.imgLogo),
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(
          horizontal: kPadding(context) * 2.5,
          vertical: kIconSize + kIconButtonPadding,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight);
}
