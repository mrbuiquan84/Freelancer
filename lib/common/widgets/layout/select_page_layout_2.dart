import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SelectPageLayout2<T> extends StatefulWidget {
  const SelectPageLayout2({
    Key? key,
    this.appBarTitle,
    this.helperText,
    this.initValue,
    this.hintSearchTextField,
    required this.choices,
  }) : super(key: key);
  final String? appBarTitle;
  final String? helperText;
  final String? hintSearchTextField;
  final List<T> choices;
  final T? initValue;

  @override
  State<SelectPageLayout2<T>> createState() => _SelectPageLayout2State<T>();
}

class _SelectPageLayout2State<T> extends State<SelectPageLayout2<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initValue ?? widget.choices[0];
  }

  buildRadio({
    bool selected = true,
  }) =>
      Container(
        height: 20.0,
        width: 20.0,
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.primaryColor : AppColors.borderColor,
          ),
        ),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryColor : const Color(0xFFD6D9F5),
            shape: BoxShape.circle,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _searchController;
    final scrSize = MediaQuery.of(context).size;
    var _minHeight = 375.0;
    return Scaffold(
      appBar: AppAppBar(
        title: Text(widget.appBarTitle ?? ''),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: kSizedBoxHeight, horizontal: kPadding(context)),
        constraints: BoxConstraints(
          minHeight: _minHeight,
          maxHeight: scrSize.height > _minHeight ? scrSize.height : _minHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              hint: widget.hintSearchTextField ?? StringConst.editToSearch,
              controller: _searchController,
              suffixIcon: AppAsset.icSearch,
            ),
            if (widget.helperText != null && widget.helperText!.isNotEmpty)
              Text(
                widget.helperText!,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                  height: 24.55 / 18.0,
                ),
              ),
            const SizedBox(height: kSizedBoxHeight),
            Expanded(
              child: ListView.builder(
                itemCount: widget.choices.length,
                itemBuilder: (_, index) {
                  var item = widget.choices[index];
                  return Container(
                    height: 24.0,
                    margin: const EdgeInsets.only(bottom: 15.0),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedValue = item;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildRadio(
                            selected: item == _selectedValue,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              item.toString(),
                              textHeightBehavior: const TextHeightBehavior(
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                              style: AppTextStyles.textStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: kSizedBoxHeight),
            Center(
              child: AppElevatedButton(
                label: StringConst.apply,
                padding: const EdgeInsets.symmetric(
                  horizontal: 65.0,
                  vertical: 10.0,
                ),
                labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
