import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class NotifButton extends StatelessWidget {
  const NotifButton({
    Key? key,
    this.onNotifButtonPressed,
    this.notifButtonKey,
  }) : super(key: key);

  final VoidCallback? onNotifButtonPressed;
  final Key? notifButtonKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onNotifButtonPressed,
      key: notifButtonKey,
      splashRadius: kSplashRadius,
      icon: SvgPicture.asset(
        AppAsset.icBell,
      ),
    );
  }
}
