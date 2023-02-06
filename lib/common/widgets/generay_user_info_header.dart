import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/app_circle_avatar.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class GeneralUserInfoHeader extends StatelessWidget {
  const GeneralUserInfoHeader({
    Key? key,
    this.avatarSize,
    required this.name,
    required this.avatar,
    required this.children,
  }) : super(key: key);

  final double? avatarSize;
  final String name;
  final String? avatar;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    var _avatarSize = avatarSize ?? (scrSize.width / 0.4).clamp(0.0, 150.0);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kBorderRadius20),
            topRight: Radius.circular(kBorderRadius20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
            color: AppColors.white,
            child: Column(
              children: [
                SizedBox(height: _avatarSize / 2 + kSizedBoxHeight),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    height: 25.0 / 20.0,
                    color: AppColors.darkerIrisBlue,
                  ),
                ),
                const SizedBox(height: kSizedBoxHeight),
                ...children,
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, -_avatarSize / 2),
          child: AppCircleAvatar(
            imgSize: _avatarSize,
            avatar: avatar,
          ),
        ),
      ],
    );
  }
}
