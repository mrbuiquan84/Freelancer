import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/common/models/empler.dart';
import 'package:freelancer/common/widgets/app_network_image.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/outlined_dotted_border_card.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class EmplerCard extends StatelessWidget {
  const EmplerCard({
    Key? key,
    this.imgSize = kCardCircleAvatarSized,
    this.nonAvatarAsset = AppAsset.imgNonAvatar,
    this.bottom,
    this.name,
    this.location,
    this.createdAt,
    this.numOfPostedJobs,
    this.avatar,
  }) : super(key: key);
  final double imgSize;
  final String nonAvatarAsset;
  final Widget? bottom;
  final String? name;
  final String? location;
  final DateTime? createdAt;
  final String? numOfPostedJobs;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    const double _rowPadding = 5.0;
    var avatarImg = AppNetworkImage(
      imageUrl: avatar,
      imgSize: imgSize,
      errorWidget: Image.asset(
        nonAvatarAsset,
        fit: BoxFit.cover,
      ),
    );
    return OutlinedDottedBorderCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: avatarImg,
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? StringConst.nonUpdateError,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                    height: 24.55 / 18.0,
                  ),
                ),
                const SizedBox(height: _rowPadding),
                IconWithTextWidget(
                  iconAsset: AppAsset.icCircleLocation,
                  text: location ?? StringConst.nonUpdateError,
                ),
                Text(
                  '${StringConst.join}: ${createdAt == null ? StringConst.nonUpdateError : createdAt!.format()}',
                  style: AppTextStyles.iconWithTextTextStyle,
                ),
                const SizedBox(height: _rowPadding),
                RichText(
                  text: TextSpan(
                    text: '${StringConst.posted}: ',
                    style: AppTextStyles.iconWithTextTextStyle,
                    children: [
                      TextSpan(
                          text: '$numOfPostedJobs ${StringConst.job}',
                          style: AppTextStyles.iconWithTextTextStyle.copyWith(
                            color: AppColors.orangeAccent,
                          )),
                    ],
                  ),
                ),
                if (bottom != null)
                  Padding(
                    padding: const EdgeInsets.only(top: _rowPadding),
                    child: bottom!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
