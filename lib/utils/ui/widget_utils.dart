import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

import 'app_padding.dart';

class WidgetUtils {
  static const CircularProgressIndicator loadingCircle =
      CircularProgressIndicator(
    color: AppColors.primaryColor,
  );

  static const Center centerLoadingCircle = Center(
    child: CircularProgressIndicator(
      color: AppColors.primaryColor,
    ),
  );

  static const Padding sectionLoading = Padding(
    padding: AppPadding.paddingAll20,
    child: Center(
      child: loadingCircle,
    ),
  );

  static const SizedBox screenBodyLoading = SizedBox.expand(
    child: Center(
      child: loadingCircle,
    ),
  );

  static List<Widget> addSizedBoxAsSeparator(
          SizedBox sizedBox, List<Widget> widgets) =>
      widgets.isEmpty
          ? widgets
          : widgets.expand((element) => [element, sizedBox]).toList()
        ..removeLast();

  static Padding getSectionEmpty(Text text, {double verticalPadding = 30}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Center(child: text),
      );

  static List<Widget> uniformWidth(List<Widget> list) =>
      list.map((e) => e is SizedBox ? e : Expanded(flex: 1, child: e)).toList();

  static SingleChildScrollView getSingleChildScrollView({
    EdgeInsetsGeometry? padding =
        const EdgeInsets.only(top: 40, bottom: 20, right: 20, left: 20),
    required List<Widget> children,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) =>
      SingleChildScrollView(
        child: padding == null
            ? Column(
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              )
            : Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
              ),
      );
}

extension SizedBoxExt on SizedBox {
  static const shrink = SizedBox.shrink();

  static const w5 = SizedBox(width: 5);

  static const h10 = SizedBox(height: 10);
  static const w10 = SizedBox(width: 10);

  static const h12 = SizedBox(height: 12);

  static const w16 = SizedBox(width: 16);

  static const h15 = SizedBox(height: 15);

  static const h20 = SizedBox(height: 20);
  static const w20 = SizedBox(width: 20);

  static const h30 = SizedBox(height: 30);
  static const h40 = SizedBox(height: 40);
  static const h50 = SizedBox(height: 50);

  static const sliverH16 = SliverToBoxAdapter(child: SizedBox(height: 16));
}
