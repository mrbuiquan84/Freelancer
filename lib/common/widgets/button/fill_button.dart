import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';

class FillButton extends StatelessWidget {
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final String text;
  final Color? backgroundColor;
  final TextStyle? style;
  final double elevation;

  const FillButton({
    Key? key,
    this.onPressed,
    this.padding,
    this.width,
    required this.text,
    this.backgroundColor,
    this.style,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: backgroundColor,
        padding: padding,
        shadowColor: Colors.black,
        elevation: elevation,
      ),
      child: Text(
        text,
        style: style ?? AppTextStyles.buttonTxtStyle,
      ),
    );
    if (width != null) current = SizedBox(width: width, child: current);

    return current;
  }
}
