import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    Key? key,
    this.isShowCancelButton = false,
    this.title,
    this.content,
    this.centerTitle = true,
    this.padding,
    this.titleTextAlign = TextAlign.left,
    this.elevation,
    this.borderRadius,
    this.shadows,
  }) : super(key: key);
  final bool isShowCancelButton;
  final String? title;
  final Widget? content;
  final bool centerTitle;
  final EdgeInsetsGeometry? padding;
  final TextAlign titleTextAlign;
  final double? elevation;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    var dialogTitle = title != null
        ? Text(
            title!,
            style: const TextStyle(
              fontFamily: AppConst.fontNunito,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 24 / 18.0,
              color: AppColors.textColor,
            ),
            textAlign: titleTextAlign,
          )
        : const SizedBox.shrink();

    var _borderRadius =
        borderRadius ?? BorderRadius.circular(kDialogBorderRadius);
    var dialog = Container(
      // margin: EdgeInsets.symmetric(horizontal: kPadding(context)),
      constraints: const BoxConstraints(
        maxWidth: 335.0,
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 12.0,
          ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: _borderRadius,
        boxShadow: shadows,
      ),
      // width: (scrSize.width * 335 / 375).clamp(0.0, 335),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              !centerTitle
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: dialogTitle,
                    )
                  : dialogTitle,
            if (content != null) content!,
          ],
        ),
      ),
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: kPadding(context)),
      // shape: RoundedRectangleBorder(
      //   borderRadius: _borderRadius,
      //   side: BorderSide(color: AppColors.primaryColor),
      // ),
      elevation: elevation,
      child: isShowCancelButton
          ? Stack(
              children: [
                dialog,
                Positioned(
                  top: -(10.0 + 20.0),
                  right: 0.0,
                  child: SvgPicture.asset(
                    AppAsset.icClose2,
                    height: 20.0,
                    width: 20.0,
                    fit: BoxFit.cover,
                    color: AppColors.white,
                  ),
                ),
              ],
              clipBehavior: Clip.none,
            )
          : dialog,
    );
  }
}
