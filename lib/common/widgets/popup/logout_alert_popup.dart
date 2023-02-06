import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';

class LogoutAlertPopup extends StatelessWidget {
  const LogoutAlertPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 23.0,
      ),
      content: Column(
        children: [
          Text(
            StringConst.logout,
            style: TextStyle(
              fontFamily: AppConst.fontNunito,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 24 / 20.0,
              color: AppColors.textColor,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0.0, 4.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SvgPicture.asset(
              AppAsset.icInfo,
              color: AppColors.orangeAccent,
              height: 40.0,
              width: 40.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              StringConst.logoutAlert,
              textAlign: TextAlign.center,
              style: AppTextStyles.normalTextStyle(
                color: const Color(0xFF464646),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          CoupleBottomOutlinedAndElevatedButtons(
            height: 40.0,
            firstLabel: StringConst.cancel,
            secondaryLabel: StringConst.agree,
            onPressedFirstButton: () {},
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
