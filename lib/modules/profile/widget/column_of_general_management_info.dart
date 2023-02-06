import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';

class ColumnOfGeneralManagementInfo extends StatelessWidget {
  const ColumnOfGeneralManagementInfo({
    Key? key,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.email,
  }) : super(key: key);

  final DateTime dob;
  final String gender;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext context) {
    buildIconWithTextRow({
      required String iconAsset,
      required String field,
      Color? color,
      double size = 30.0,
      double iconSize = 15.0,
    }) {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          children: [
            Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: (color ?? AppColors.primaryColor).withOpacity(0.25),
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                iconAsset,
                fit: BoxFit.cover,
                height: iconSize,
                width: iconSize,
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Text(
                field,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.iconWithTextTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        buildIconWithTextRow(
          iconAsset: AppAsset.icCalendarRange,
          field: '${StringConst.dob}:  ${dob.format()}',
        ),
        buildIconWithTextRow(
          iconAsset: AppAsset.icGender,
          field: '${StringConst.gender}:  $gender',
          color: AppColors.orangeAccent,
        ),
        buildIconWithTextRow(
          iconAsset: AppAsset.icPhone,
          field: '${StringConst.phone}:  $phone',
        ),
        buildIconWithTextRow(
          iconAsset: AppAsset.icMailWithoutHeader,
          field: '${StringConst.mail}:  $email',
          color: AppColors.orangeAccent,
        ),
      ],
    );
  }
}
