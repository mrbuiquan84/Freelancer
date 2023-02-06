import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class SaveJobSuccessPopup extends StatelessWidget {
  const SaveJobSuccessPopup({
    Key? key,
    required this.successAlert,
  }) : super(key: key);
  final String successAlert;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: '',
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 28.0,
      ),
      content: Column(
        children: [
          Image.asset(AppAsset.imgGreenTickSuccess),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              successAlert,
              style: const TextStyle(
                fontFamily: AppConst.fontNunito,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 22 / 16.0,
                color: AppColors.textColor,
              ),
            ),
          ),
          AppOutlinedButton(
            child: StringConst.close,
            borderRadius: BorderRadius.circular(15.0),
            onPressed: () {},
            padding: const EdgeInsets.symmetric(
              horizontal: 58.5,
              vertical: 9.5,
            ),
            labelTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 21 / 18.0,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
