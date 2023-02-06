import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AppAsset.icBackCircle),
      splashRadius: kIconSize - kIconButtonPadding,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
        Navigator.of(context).maybePop();
      },
    );
  }
}
