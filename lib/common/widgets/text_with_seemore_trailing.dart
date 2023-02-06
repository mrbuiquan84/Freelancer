import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class TextWithClickableTrailing extends StatelessWidget {
  const TextWithClickableTrailing({
    Key? key,
    required this.text,
    this.trailing = StringConst.seeMore,
    this.textTextStyle,
    this.trailingTextStyle,
    this.onTap,
    this.sep = '    ',
  }) : super(key: key);
  final String text;
  final String trailing;
  final VoidCallback? onTap;
  final TextStyle? textTextStyle;
  final TextStyle? trailingTextStyle;
  final String sep;

  @override
  Widget build(BuildContext context) {
    var _textStyle = textTextStyle ??
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          height: 24.0 / 16.0,
          color: AppColors.textColor,
        );

    var _trailingStyle = trailingTextStyle ??
        _textStyle.copyWith(
          fontStyle: FontStyle.italic,
          color: AppColors.orangeAccent,
        );

    return RichText(
      text: TextSpan(
        text: text + sep,
        style: _textStyle,
        children: [
          TextSpan(
            text: StringConst.seeDetail,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: _trailingStyle,
          ),
        ],
      ),
    );
  }
}
