import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    Key? key,
    required this.rating,
    this.widthSep = 0.0,
  }) : super(key: key);
  final double rating;
  final double widthSep;

  @override
  Widget build(BuildContext context) {
    var _iconSize = 25.0;

    Widget itemBuilder(
      BuildContext context,
      int index,
    ) {
      var value = (rating - index).clamp(0.0, 1.0);
      var iconOulinedWidth = 5.0;
      return Padding(
        padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(left: widthSep),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              AppAsset.icStar,
              color: AppColors.orangeAccent,
              height: _iconSize + iconOulinedWidth,
              width: _iconSize + iconOulinedWidth,
            ),
            ClipRRect(
              clipper: _CustomClipper(value: value),
              child: SvgPicture.asset(
                AppAsset.icStar,
                height: _iconSize,
                width: _iconSize,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          List.generate(kMaxRating, (index) => itemBuilder(context, index))
              .toList(),
    );
  }
}

class _CustomClipper extends CustomClipper<RRect> {
  _CustomClipper({required this.value});

  final double value;

  @override
  getClip(Size size) {
    return RRect.fromRectAndRadius(
      Offset(size.width * value, 0.0) & size,
      Radius.zero,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
