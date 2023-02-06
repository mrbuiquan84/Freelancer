import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_drop_down_button.dart';
import 'package:freelancer/common/widgets/text_field_label.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class DropDownTextFieldButton<T> extends StatefulWidget {
  const DropDownTextFieldButton({
    Key? key,
    required this.choices,
    this.elevation = kElevation,
    this.labelTextStyle,
    this.label,
    this.hint,
    this.controller,
    this.isRequired = false,
    this.initChoice,
    this.buttonTextStyle,
    this.padding = const EdgeInsets.only(bottom: kTextFieldBottomPadding),
    this.onChanged,
    this.itemHeight,
    this.borderColor,
  }) : super(key: key);

  final double elevation;
  final TextStyle? labelTextStyle;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool isRequired;
  final List<T> choices;
  final T? initChoice;
  final TextStyle? buttonTextStyle;
  final EdgeInsetsGeometry padding;
  final ValueChanged<T>? onChanged;
  final double? itemHeight;
  final Color? borderColor;

  @override
  State<DropDownTextFieldButton<T>> createState() =>
      _DropDownTextFieldButtonState<T>();
}

class _DropDownTextFieldButtonState<T>
    extends State<DropDownTextFieldButton<T>> {
  late T _choice;

  @override
  void initState() {
    _choice = widget.initChoice ?? widget.choices[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = widget.buttonTextStyle ?? AppTextStyles.hintTxtStyle;
    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          if (widget.label != null)
            TextFieldLabel(
              label: widget.label!,
              isRequired: widget.isRequired,
              labelTextStyle: widget.labelTextStyle,
            ),
          AppDropDownButton(
            choices: widget.choices,
            initChoice: _choice,
            radius: kBorderRadius10,
            itemTextStyles: widget.choices.map((e) => textStyle).toList(),
            itemHeight: widget.itemHeight ?? 40.0,
            borderColor: widget.borderColor,
            onTap: (dynamic item) {
              if (widget.onChanged != null) {
                widget.onChanged!(item as T);
              }
            },
          ),
        ],
      ),
    );
  }
}
