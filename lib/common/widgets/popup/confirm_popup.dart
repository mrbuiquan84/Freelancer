import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class ConfirmPopup extends StatelessWidget {
  const ConfirmPopup({
    Key? key,
    required this.title,
    this.onPressedFirstButton,
    this.onPressedSecondButton,
    this.content,
    this.firstLabel = StringConst.agree,
    this.secondeLabel = StringConst.cancel,
  }) : super(key: key);
  final String title;
  final VoidCallback? onPressedFirstButton;
  final VoidCallback? onPressedSecondButton;
  final Widget? content;
  final String firstLabel;
  final String secondeLabel;

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
            title,
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
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: content,
          ),
          const SizedBox(height: 30.0),
          CoupleBottomOutlinedAndElevatedButtons(
            height: 40.0,
            firstLabel: firstLabel,
            secondaryLabel: secondeLabel,
            onPressedFirstButton: onPressedFirstButton,
            onPressedSecondaryButton:
                onPressedSecondButton ?? () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
