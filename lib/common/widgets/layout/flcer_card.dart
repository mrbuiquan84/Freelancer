import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/app_chip.dart';
import 'package:freelancer/common/widgets/app_network_image.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class FlcerApplyJobCard extends StatelessWidget {
  const FlcerApplyJobCard({
    Key? key,
    required this.flcerName,
    this.price,
    this.nonAvatarAsset = AppAsset.imgNonAvatar,
    this.imgSize = kCardCircleAvatarSized,
    this.avatar,
    required this.userJob,
    required this.flcerId,
    required this.skills,
    required this.rating,
  }) : super(key: key);

  final String flcerName;
  final String? price;
  final String nonAvatarAsset;
  final double imgSize;
  final String? avatar;
  final String userJob;
  final String flcerId;
  final List<String> skills;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    var avatarImg = AppNetworkImage(
      imageUrl: avatar,
      imgSize: imgSize,
      errorWidget: Image.asset(
        nonAvatarAsset,
        fit: BoxFit.cover,
      ),
    );

    var _rowPadding = kCardRowVerticalPadding;

    buildTextStyle({
      double fontSize = 14.0,
      Color? color,
      FontWeight fontWeight = FontWeight.w400,
    }) =>
        TextStyle(
          fontFamily: AppConst.fontNunito,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: 19.1 / fontSize,
          color: color ?? AppColors.textColor,
        );
    var _maxRating = kMaxRating;
    var flcerRating = rating;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius20)),
      elevation: kElevation,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(child: avatarImg),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flcerName, // ?? StringConst.nonUpdateError,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          height: 21.82 / 16.0,
                        ),
                      ),
                      SizedBox(height: _rowPadding),
                      IconWithTextWidget(
                        iconAsset: AppAsset.icBag,
                        text: userJob,
                        textStyle: AppTextStyles.iconWithTextTextStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: _rowPadding),
                      RichText(
                        text: TextSpan(
                          text: '${StringConst.setPrice}: ',
                          style: buildTextStyle(),
                          children: [
                            TextSpan(
                              text: price,
                              style: buildTextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: _rowPadding),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${StringConst.rating}: ',
                              style: buildTextStyle(),
                              children: [
                                TextSpan(
                                  text:
                                      '${rating ?? StringConst.error}/$_maxRating ',
                                  style: buildTextStyle(
                                    color: AppColors.orangeAccent,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              // width: 100,
                              height: 20.0,
                              child: ListView.separated(
                                itemCount: _maxRating,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 4.0),
                                itemBuilder: (_, index) {
                                  var item =
                                      index <= ((flcerRating ?? kMaxRating) - 1)
                                          ? SvgPicture.asset(AppAsset.icStar)
                                          : SvgPicture.asset(
                                              AppAsset.icStarOutlined);
                                  return item;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: _rowPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '${StringConst.skill}: ',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    height: 20.46 / 15.0,
                  ),
                ),
                const SizedBox(width: kSizedBoxWidth),
                Expanded(
                  child: skills.isNotEmpty
                      ? Wrap(
                          runSpacing: 10.0,
                          children: skills
                              .map(
                                (e) => AppChip(
                                  label: e,
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          StringConst.notHadYet,
                          style: buildTextStyle(
                            color: AppColors.gray,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
