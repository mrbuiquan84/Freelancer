import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ToggleOutlinedButton<T> extends StatefulWidget {
  const ToggleOutlinedButton({
    Key? key,
    required this.values,
    this.selectedValue,
    this.isMaxWidth = false,
    this.radius,
    this.labelAlignment,
    this.onChanged,
  }) : super(key: key);

  final List<T> values;
  final int? selectedValue;
  final bool isMaxWidth;
  final double? radius;
  final AlignmentGeometry? labelAlignment;
  final ValueChanged<T>? onChanged;

  @override
  State<ToggleOutlinedButton> createState() => _ToggleOutlinedButtonState<T>();
}

class _ToggleOutlinedButtonState<T> extends State<ToggleOutlinedButton> {
  late T _selectedValue;

  buildTextStyle(
    BuildContext context, {
    Color? color,
  }) {
    return AppTextStyles.hintTxtStyle.apply(
      color: color,
    );
  }

  @override
  void initState() {
    _selectedValue = widget.selectedValue ?? widget.values[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var longestLabel =
        widget.values[0].toString().length >= widget.values[1].toString().length
            ? widget.values[0].toString()
            : widget.values[1].toString();
    final Text label = Text(longestLabel, style: buildTextStyle(context));

    final lognestLabelSize = label.getSize(maxLines: 1);
    double horizontalPadding = kButtonHorizontalPadding;
    double? buttonWidth;

    final _radius = Radius.circular(widget.radius ?? kTextFieldBorderRadius);

    return LayoutBuilder(
      builder: (context, constrain) {
        var maxWidth = constrain.maxWidth;
        if (widget.isMaxWidth) {
          buttonWidth = maxWidth / 2;
        } else {
          if (maxWidth <=
              (2 * lognestLabelSize.width + horizontalPadding * 2)) {
            horizontalPadding = (maxWidth - 2 * lognestLabelSize.width) / 4;
            buttonWidth = maxWidth / 2;
          } else {
            buttonWidth = lognestLabelSize.width + 2 * horizontalPadding;
          }
        }
        return FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.values.asMap().entries.map(
                (e) {
                  var index = e.key;
                  var value = e.value;
                  var isSelected = _selectedValue == value;
                  return AppOutlinedButton(
                    labelAlignment: widget.labelAlignment,
                    width: buttonWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: kTextFieldLabelBottomPadding,
                    ),
                    child: value.toString(),
                    buttonPrimaryColor: isSelected ? null : AppColors.hintColor,
                    labelTextStyle: buildTextStyle(
                      context,
                      color: isSelected ? AppColors.primaryColor : null,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: index == 0 ? _radius : Radius.zero,
                      bottomLeft: index == 0 ? _radius : Radius.zero,
                      topRight: index == 1 ? _radius : Radius.zero,
                      bottomRight: index == 1 ? _radius : Radius.zero,
                    ),
                    backgroundColor: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.12)
                        : null,
                    onPressed: () {
                      if (_selectedValue != value) {
                        setState(() {
                          _selectedValue = value;
                          if (widget.onChanged != null) {
                            widget.onChanged!(_selectedValue);
                          }
                        });
                      }
                    },
                  );
                },
              ).toList(),
            ],
          ),
        );
      },
    );
  }
}
