import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';

class IconWithTextWidget extends StatelessWidget {
  const IconWithTextWidget({
    Key? key,
    required this.iconAsset,
    required this.text,
    this.iconColor,
    this.textStyle,
    this.iconSize = 15.0,
    this.padding = const EdgeInsets.only(bottom: 10.0),
    this.separatedWidth = 5.0,
    this.mainAxisSize = MainAxisSize.max,
  }) : super(key: key);
  final String iconAsset;
  final String text;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final double separatedWidth;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    var text2 = Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textHeightBehavior: const TextHeightBehavior(
        leadingDistribution: TextLeadingDistribution.even,
      ),
      style: textStyle ?? AppTextStyles.iconWithTextTextStyle,
    );
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            color: iconColor,
            height: iconSize,
            width: iconSize,
            fit: BoxFit.cover,
          ),
          SizedBox(width: separatedWidth),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: text2,
            ),
          ),
        ],
      ),
    );
  }
}
