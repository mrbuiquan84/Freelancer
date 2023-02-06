import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/outlined_radio_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/layout/unauth_page_layout.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

class SelectPageLayout<T> extends StatefulWidget {
  const SelectPageLayout({
    Key? key,
    this.appBarTitle,
    this.helperText,
    this.initValue,
    this.maxSelect = 1,
    this.choices = const [],
    this.onAppliedButtonPressed,
  }) : super(key: key);

  final String? appBarTitle;
  final String? helperText;
  final List<T> choices;
  final List<T>? initValue;
  final int maxSelect;
  final ValueChanged<List<T>>? onAppliedButtonPressed;

  @override
  State<SelectPageLayout<T>> createState() => _SelectPageLayoutState<T>();
}

class _SelectPageLayoutState<T> extends State<SelectPageLayout<T>> {
  final _searchController = TextEditingController();
  // final double _kItemHeight = 46.0;
  // final int _numOfItems = 4;
  late List<T> _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = [...widget.initValue ?? []];
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedValue);
    return UnAuthPageLayout(
      appBarTitle: widget.appBarTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.helperText != null)
            Text(
              widget.helperText!,
              style: AppTextStyles.textStyle,
              textAlign: TextAlign.center,
            ),
          AppTextField(
            padding: const EdgeInsets.symmetric(
              vertical: kTextFieldBottomPadding * 2,
            ),
            elevation: 0.0,
            hint: StringConst.editToSearch,
            controller: _searchController,
            suffixIcon: AppAsset.icSearch,
          ),
          // const SizedBox(height: 48.0 - kTextFieldBottomPadding * 2),
          Container(
            constraints: const BoxConstraints(maxHeight: 200.0),
            child: ListView.builder(
              itemCount: widget.choices.length,
              shrinkWrap: true,
              itemBuilder: _itemBuilder,
            ),
          ),
          const SizedBox(height: 50.0),
          AppElevatedButton(
            label: StringConst.apply,
            padding: const EdgeInsets.symmetric(
              horizontal: 43.0,
              vertical: kButtonLabelVerticalPadding,
            ),
            onPressed: () {
              if (widget.onAppliedButtonPressed != null) {
                widget.onAppliedButtonPressed!(_selectedValue);
              }
            },
            elevation: 0.0,
          ),
          const SizedBox(height: 78.0),
        ],
      ),
    );
  }

  Widget _itemBuilder(
    BuildContext context,
    int index,
  ) {
    var item = widget.choices[index];
    var isSelected = _selectedValue.contains(item);
    return CustomRadioButton(
      value: item,
      selected: isSelected,
      height: 46.0,
      borderRadius: 0.0,
      border: const Border(
        top: BorderSide(width: 1, color: Colors.transparent),
      ),
      beforeChange: (selected) {
        if (selected == false) {
          if (_selectedValue.length >= widget.maxSelect) {
            showToast(StringConst.selectOutOfMaxRange(max: widget.maxSelect));
            return false;
          }
        }
        return true;
      },
      onChanged: (value) {
        if (value) {
          _selectedValue.add(item);
        } else {
          _selectedValue.remove(item);
        }
      },
    );
  }
}
