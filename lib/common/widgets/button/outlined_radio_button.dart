import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class CustomRadioButton<T> extends StatefulWidget {
  const CustomRadioButton({
    Key? key,
    this.onChanged,
    this.borderRadius,
    this.height = 40,
    this.border,
    this.textStyle,
    this.beforeChange,
    required this.value,
    required this.selected,
  }) : super(key: key);

  final T value;
  final ValueChanged<bool>? onChanged;
  final bool selected;
  final double? borderRadius;
  final double height;
  final Border? border;
  final TextStyle? textStyle;
  final bool Function(bool)? beforeChange;

  @override
  State<CustomRadioButton<T>> createState() => CustomRadioButtonState<T>();
}

class CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  bool _selected = false;
  BorderRadius? borderRadius;
  late final TextStyle _textStyle;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
    borderRadius = widget.borderRadius == 0.0
        ? null
        : BorderRadius.circular(
            kTextFieldBorderRadius,
          );
    _textStyle = widget.textStyle ?? AppTextStyles.radioTextStyle;
  }

  void _onChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(_selected);
    }
  }

  _buildBoxDecoration(bool selected) => BoxDecoration(
        borderRadius: borderRadius,
        border: widget.border != null
            ? Border(
                top: widget.border!.top.copyWith(
                  color:
                      selected ? AppColors.primaryColor : AppColors.borderColor,
                ),
                bottom: widget.border!.bottom.copyWith(
                  color:
                      selected ? AppColors.primaryColor : AppColors.borderColor,
                ),
                left: widget.border!.left.copyWith(
                  color:
                      selected ? AppColors.primaryColor : AppColors.borderColor,
                ),
                right: widget.border!.right.copyWith(
                  color:
                      selected ? AppColors.primaryColor : AppColors.borderColor,
                ),
              )
            : Border.all(
                color:
                    selected ? AppColors.primaryColor : AppColors.borderColor,
              ),
      );

  @override
  Widget build(BuildContext context) {
    var radio = Container(
      height: 20.0,
      width: 20.0,
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _selected ? AppColors.primaryColor : AppColors.borderColor,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: _selectColor(),
      ),
    );

    var button = MaterialButton(
      onPressed: _onTap,
      height: widget.height,
      shape: borderRadius != null
          ? RoundedRectangleBorder(
              borderRadius: borderRadius!,
              side: BorderSide(
                color: _selectColor(unSelectedColor: AppColors.borderColor),
              ),
            )
          : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: kTextFieldIconPadding),
      splashColor: AppColors.primaryColor.withOpacity(0.15),
      child: Row(
        children: [
          radio,
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.value.toString(),
              style: _textStyle.copyWith(
                color: _selectColor(unSelectedColor: _textStyle.color),
              ),
            ),
          ),
        ],
      ),
    );

    return borderRadius == null
        ? Container(
            decoration: _buildBoxDecoration(_selected),
            child: button,
          )
        : button;
  }

  Color _selectColor({
    Color? unSelectedColor,
  }) =>
      _selected ? AppColors.primaryColor : unSelectedColor ?? AppColors.none;

  void _onTap() {
    if (widget.beforeChange != null && !widget.beforeChange!(_selected)) {
      return;
    }
    changeState();
    _onChanged();
  }

  void changeState() => setState(() {
        _selected = !_selected;
      });
}
