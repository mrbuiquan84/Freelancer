import 'package:flutter/cupertino.dart';

extension TextExtension on Text {
  bool hasTextOverflow({
    double minWidth = 0,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  Size getSize({
    double minWidth = 0,
    double maxWidth = double.infinity,
    int? maxLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
    return (textPainter
          ..layout(
            minWidth: minWidth,
            maxWidth: maxWidth,
          ))
        .size;
  }
}
