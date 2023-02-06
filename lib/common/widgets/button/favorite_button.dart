import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    this.onPressed,
    this.favorite = false,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final bool favorite;

  @override
  FavoriteButtonState createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  late bool _favorite;
  final double _iconSize = kIconSize;
  final Color _buttonPrimaryColor = AppColors.iconColor;
  late final ButtonStyle _style;
  bool get favorite => _favorite;

  @override
  void initState() {
    super.initState();
    _favorite = widget.favorite;
    _style = OutlinedButton.styleFrom(
      backgroundColor: AppColors.backgroundColor,
      side: BorderSide(
        color: _buttonPrimaryColor,
      ),
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius10),
          bottomRight: Radius.circular(kBorderRadius10),
        ),
      ),
    );
  }

  updateState() {
    setState(() {
      _favorite = !_favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kFavoriteButtonSize,
      width: kFavoriteButtonSize,
      child: OutlinedButton(
        onPressed: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
          updateState();
        },
        style: _style,
        child: SvgPicture.asset(
          _favorite ? AppAsset.icHeart : AppAsset.icHeartOutlined,
          color: _buttonPrimaryColor,
          height: _iconSize,
          width: _iconSize,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
