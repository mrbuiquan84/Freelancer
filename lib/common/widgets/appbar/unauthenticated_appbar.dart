import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_bar_back_button.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class UnAuthAppBar extends StatelessWidget {
  const UnAuthAppBar({
    height = 60.0,
    title,
    Key? key,
  })  : _height = height,
        _title = title,
        super(key: key);

  final double _height;
  double get appbarHeight => _height;

  final String? _title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(),
      elevation: 0.0,
      centerTitle: true,
      toolbarHeight: kStatusbarHeight + _height,
      leading: const Align(
        alignment: Alignment.bottomLeft,
        child: AppBackButton(),
      ),
      backgroundColor: AppColors.backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: _title != null
            ? Text(
                _title!,
                style: AppTextStyles.appbarTitleTxtStyle,
              )
            : null,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: kIconButtonPadding),
      ),
    );
  }
}
