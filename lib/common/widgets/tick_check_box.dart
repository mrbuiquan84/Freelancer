import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class TickCheckBox<T> extends StatefulWidget {
  const TickCheckBox({
    Key? key,
    required this.item,
    this.selected = false,
    this.onChanged,
  }) : super(key: key);
  final T item;
  final bool selected;
  final ValueChanged<bool>? onChanged;

  @override
  State<TickCheckBox<T>> createState() => TickCheckBoxState<T>();
}

class TickCheckBoxState<T> extends State<TickCheckBox<T>>
    with SingleTickerProviderStateMixin {
  late bool _selected;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
    _controller = AnimationController(
      vsync: this,
      value: _selected ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          _selected = !_selected;
          if (widget.onChanged != null) {
            widget.onChanged!(_selected);
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            var lerpColor = Color.lerp(
              AppColors.borderColor,
              AppColors.primaryColor,
              _controller.value,
            )!;
            var lerpTextColor = Color.lerp(
              AppColors.textColor,
              AppColors.primaryColor,
              _controller.value,
            )!;
            return Row(
              children: [
                Container(
                  height: kCheckboxSize,
                  width: kCheckboxSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lerpColor,
                    ),
                  ),
                  child: Transform.scale(
                    scale: _controller.value,
                    child: SvgPicture.asset(AppAsset.icTicked),
                  ),
                ),
                const SizedBox(width: kSizedBoxWidth),
                Expanded(
                  child: Text(
                    widget.item == null
                        ? StringConst.all
                        : widget.item.toString(),
                    style: AppTextStyles.textStyle.copyWith(
                      color: lerpTextColor,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
