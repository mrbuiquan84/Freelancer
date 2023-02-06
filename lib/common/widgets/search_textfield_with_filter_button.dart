import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SearchTextFieldWithFilterButton extends StatelessWidget {
  const SearchTextFieldWithFilterButton({
    Key? key,
    required this.searchField,
  }) : super(key: key);
  final AppTextField searchField;

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey();
    ValueNotifier<Size?> _size = ValueNotifier(null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _size.value = (_key.currentContext!.findRenderObject() as RenderBox).size;
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            key: _key,
            child: searchField,
          ),
        ),
        const SizedBox(width: kSizedBoxWidth),
        ValueListenableBuilder<Size?>(
          valueListenable: _size,
          child: SvgPicture.asset(
            AppAsset.icLevels,
            fit: BoxFit.cover,
          ),
          builder: (context, size, child) {
            return size != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: InkWell(
                      child: Container(
                        width: 45.0,
                        height: size.height - kTextFieldBottomPadding,
                        color: AppColors.primaryColor,
                        padding: const EdgeInsets.all(7.0),
                        alignment: Alignment.center,
                        child: child,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
