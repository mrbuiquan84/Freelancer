import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';

class CateHeader extends StatelessWidget {
  const CateHeader({
    this.showArrowButton = true,
    this.onPressedArrowButton,
    required this.header,
    Key? key,
  }) : super(key: key);
  final bool showArrowButton;
  final VoidCallback? onPressedArrowButton;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            header,
            style: AppTextStyles.cateHeaderStyle,
            maxLines: 1,
            textHeightBehavior: const TextHeightBehavior(
              leadingDistribution: TextLeadingDistribution.even,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        if (showArrowButton)
          IconButton(
            icon: SvgPicture.asset(
              AppAsset.icRightArrow,
              height: 10,
              width: 10,
              fit: BoxFit.cover,
            ),
            padding: EdgeInsets.zero,
            splashRadius: 8,
            splashColor: Colors.red,
            constraints: const BoxConstraints(
              maxHeight: 12,
              maxWidth: 12,
            ),
            onPressed: () =>
                (onPressedArrowButton != null) ? onPressedArrowButton!() : null,
          ),
      ],
    );
  }
}
