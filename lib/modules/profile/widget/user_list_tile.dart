import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/app_circle_avatar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    required this.name,
    required this.location,
    required this.joinDate,
    this.showCameraButton = false,
    this.onTapCameraButton,
    this.point,
    this.avatar,
    this.heroKeyTag,
  }) : super(key: key);

  final String name;
  final String location;
  final DateTime joinDate;
  final int? point;
  final bool showCameraButton;
  final VoidCallback? onTapCameraButton;
  final String? avatar;
  final String? heroKeyTag;

  @override
  Widget build(BuildContext context) {
    const joinDateRowTextStyle = TextStyle(
      fontSize: 14.0,
      height: 19.1 / 14.0,
      color: AppColors.textColor,
    );

    var appCircleAvatar = AppCircleAvatar(
      nonAvatarAsset: AppAsset.imgColoredNonAvatar1,
      imgSize: 100.0,
      avatar: avatar,
    );
    var avatarWidget = Stack(
      alignment: Alignment.bottomRight,
      children: [
        heroKeyTag != null
            ? Hero(
                tag: heroKeyTag!,
                child: appCircleAvatar,
              )
            : appCircleAvatar,
        if (showCameraButton)
          InkWell(
            child: SvgPicture.asset(AppAsset.icCircleCamera),
            borderRadius: BorderRadius.circular(kBorderRadius),
            radius: kSplashRadius * 1.5,
            onTap: onTapCameraButton,
          ),
      ],
    );
    return Row(
      children: [
        avatarWidget,
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  height: 24.55 / 18.0,
                ),
              ),
              const SizedBox(height: 5.0),
              IconWithTextWidget(
                iconAsset: AppAsset.icCircleLocation,
                text: location,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 5.0),
              RichText(
                text: TextSpan(
                  text: '${StringConst.join}: ',
                  style: joinDateRowTextStyle,
                  children: [
                    TextSpan(
                      text: joinDate.format(),
                      style: joinDateRowTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (point != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: RichText(
                    text: TextSpan(
                      text: '${StringConst.remainPoint}: ',
                      style: joinDateRowTextStyle,
                      children: [
                        TextSpan(
                          text: point!.toString(),
                          style: joinDateRowTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
