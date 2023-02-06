import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class DotLine extends StatelessWidget {
  const DotLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.fromHeight(1.0),
      foregroundPainter: const _DotPainter(),
      child: Container(),
    );
  }
}

class _DotPainter extends CustomPainter {
  const _DotPainter({
    this.dotWidth = 3.0,
  });

  final double dotWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.gray3
      ..strokeWidth = 0.0
      ..style = PaintingStyle.stroke;
    for (var p = 0.0; p < size.width; p += 2 * dotWidth) {
      canvas.drawLine(Offset(p, 0.0), Offset(p + dotWidth, 0.0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
