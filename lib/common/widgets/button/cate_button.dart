import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/models/cate_data.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class CateButton extends StatefulWidget {
  const CateButton({
    Key? key,
    required this.data,
    this.selected = false,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final CateData data;
  final bool selected;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  State<CateButton> createState() => _CateButtonState();
}

class _CateButtonState extends State<CateButton> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // if (!_selected) {
        //   setState(() {
        //     _selected = true;
        //   });
        // }
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: _selected ? AppColors.lightIrisBlue : null,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius10),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.primaryColor,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow25,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 7.0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 7.0,
              vertical: 5.0,
            ),
            child: SvgPicture.asset(
              widget.data.asset,
              color: AppColors.white,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10.0),
          FittedBox(
            // width: 120,
            child: Text(
              widget.data.cate.toString(),
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle.copyWith(
                fontSize: 14.0,
                height: 20.0 / 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
