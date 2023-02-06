import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class StatusContainer<T> extends StatelessWidget {
  const StatusContainer({
    Key? key,
    this.defaultColor,
    this.statusTextStyle,
    this.width,
    required this.value,
    required this.group,
    required this.colors,
    this.onTap,
  }) : super(key: key);
  final T value;
  final List<T> group;
  final List<Color> colors;
  final Color? defaultColor;
  final TextStyle? statusTextStyle;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    _buildStatusButtonColor(T value) {
      var index = group.indexWhere((e) => e == value);
      return index != -1 ? colors[index] : defaultColor;
    }

    return Material(
      color: _buildStatusButtonColor(value),
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: onTap,
        child: Container(
          width: (MediaQuery.of(context).size.width - kPadding(context)) / 2,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Text(
            value.toString(),
            maxLines: 1,
            textHeightBehavior: const TextHeightBehavior(
              leadingDistribution: TextLeadingDistribution.even,
            ),
            overflow: TextOverflow.ellipsis,
            style: statusTextStyle ??
                const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 21.82 / 16.0,
                  color: AppColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
