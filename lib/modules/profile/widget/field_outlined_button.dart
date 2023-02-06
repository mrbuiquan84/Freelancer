import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class FieldOutlinedButton extends StatelessWidget {
  const FieldOutlinedButton({
    Key? key,
    required this.iconAsset,
    required this.fieldName,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final Color? color;
  final String iconAsset;
  final String fieldName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: AppOutlinedButton(
        borderColor: color,
        onPressed: onPressed,
        height: 46.0,
        // padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        borderRadius: BorderRadius.circular(kBorderRadius10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconWithTextWidget(
            iconAsset: iconAsset,
            text: fieldName,
            iconColor: color,
            textStyle:
                AppTextStyles.iconWithTextTextStyle.copyWith(color: color),
            separatedWidth: 15.0,
            iconSize: 22.0,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
