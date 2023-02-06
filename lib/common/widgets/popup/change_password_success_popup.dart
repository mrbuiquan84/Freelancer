import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class ChangePasswordSuccessPopup extends StatelessWidget {
  const ChangePasswordSuccessPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      isShowCancelButton: true,
      content: Column(
        children: [
          Image.asset(AppAsset.imgTripleStarSuccess),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              StringConst.youChangedPasswordSuccessfully,
              style: const TextStyle(
                fontFamily: AppConst.fontNunito,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 24 / 16.0,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          AppOutlinedButton(
            child: StringConst.close,
            labelTextStyle: const TextStyle(
              fontFamily: AppConst.fontNunito,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 24 / 16.0,
              color: AppColors.orangeAccent,
            ),
            onPressed: () {},
            borderColor: AppColors.orangeAccent,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 54.0,
            ),
          ),
        ],
      ),
    );
  }
}
