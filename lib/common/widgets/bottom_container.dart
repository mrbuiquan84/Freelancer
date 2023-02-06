
import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_border_and_radius.dart';
import 'package:freelancer/utils/ui/widget_utils.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key, this.children}) : super(key: key);

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    // final double horizontalPadding = 16;
    // final double spaceBetweenChildren = 20;

    // final double childrenWidth = (MediaQuery.of(context).size.width / 1.9) -
    //     horizontalPadding -
    //     spaceBetweenChildren;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: AppBorderAndRadius.defaultRadius,
          topRight: AppBorderAndRadius.defaultRadius,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 4,
            color: AppColors.shadow10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children?.length == 1
            ? children!
            : children != null
            ? WidgetUtils.addSizedBoxAsSeparator(
          const SizedBox(width: 11),
          WidgetUtils.uniformWidth(children!),
        )
        // children!
        // .uniformWidth(context: context)
        // .map<SizedBox>((e) => SizedBox(
        //       width: childrenWidth,
        //       child: e,
        //     ))
        // .toList()
        // .addHorizontalSpacing(20)
            : [],
        // children: children ?? [],
      ),
    );
  }
}
