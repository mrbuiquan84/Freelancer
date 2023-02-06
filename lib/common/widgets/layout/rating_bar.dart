import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.rating,
    this.maxRating,
    this.unRatingIcon,
    this.unRatingColor,
    this.ratingColor,
  }) : super(key: key);
  final double rating;
  final int? maxRating;
  final Widget? unRatingIcon;
  final Color? unRatingColor;
  final Color? ratingColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.0,
      // width: 100.0,
      child: ListView.builder(
        itemCount: maxRating ?? kMaxRating,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return (index < rating - 1)
              ? SvgPicture.asset(
                  AppAsset.icStar,
                  color: ratingColor,
                )
              : (unRatingIcon ??
                  SvgPicture.asset(
                    AppAsset.icStarOutlined,
                    color: unRatingColor ?? AppColors.unRatedIconColor,
                  ));
        },
      ),
    );
  }
}
