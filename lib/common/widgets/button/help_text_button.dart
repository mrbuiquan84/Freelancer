import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';

class HelpTextButton extends StatelessWidget {
  const HelpTextButton({
    Key? key,
    required this.header,
    required this.label,
    this.onPressed,
    this.padding,
    this.headerTextStyle,
    this.labelTextStyle,
  }) : super(key: key);

  final String header;
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? headerTextStyle;
  final TextStyle? labelTextStyle;

  @override
  Widget build(BuildContext context) {
    _buildTxtStyle(
      BuildContext context, {
      required double size,
      required FontStyle fontStyle,
      required FontWeight fontWeight,
      Color color = AppColors.textColor,
    }) {
      return TextStyle(
        fontFamily: AppConst.fontNunito,
        fontSize: size,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: color,
      );
    }

    var _labelTextStyle = labelTextStyle ??
        _buildTxtStyle(
          context,
          size: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: AppColors.orangeAccent,
        );

    var buttonLabel = Text(
      label.toUpperCase(),
      maxLines: 1,
      textHeightBehavior: const TextHeightBehavior(
        leadingDistribution: TextLeadingDistribution.even,
      ),
      overflow: TextOverflow.visible,
      style: _labelTextStyle,
    );

    var textButton = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: buttonLabel,
    );

    var _headerTextStyle = headerTextStyle ??
        _buildTxtStyle(
          context,
          size: 15,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        );

    var headerText = Text(
      header,
      textHeightBehavior: const TextHeightBehavior(
        leadingDistribution: TextLeadingDistribution.even,
      ),
      style: _headerTextStyle,
    );
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          headerText,
          const SizedBox(width: 5.0),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constrain) {
                if (buttonLabel.hasTextOverflow(
                  maxWidth: constrain.maxWidth,
                )) {
                  return FittedBox(child: textButton);
                } else {
                  return textButton;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
