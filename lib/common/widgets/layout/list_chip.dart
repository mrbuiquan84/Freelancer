import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ListChip<T> extends StatelessWidget {
  const ListChip({
    Key? key,
    required this.values,
    this.limit,
  }) : super(key: key);
  final List<T> values;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    var numOfItemDisplay = limit ?? values.length;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: values.asMap().entries.map(
          (e) {
            var index = e.key;
            var item = e.value;
            if (index <= numOfItemDisplay) {
              final Widget text;
              Color? bgColor;
              TextStyle? labelStyle;
              if (index < numOfItemDisplay) {
                text = Text(
                  item.toString(),
                );
              } else {
                text = Text(
                  '+${values.length - numOfItemDisplay}',
                );
                bgColor = AppColors.primaryColor;
                labelStyle = AppTextStyles.chipTextStyle.copyWith(
                  color: AppColors.white,
                );
              }
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Chip(
                  label: text,
                  backgroundColor: bgColor,
                  labelStyle: labelStyle,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius10),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ).toList(),
      ),
    );
  }
}
