import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.header,
    this.padding,
  }) : super(key: key);
  final String header;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                header,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontFamily: AppConst.fontNunito,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 27.66 / 18.0,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            color: AppColors.primaryColor,
            height: 2.0,
            width: 24.0,
          ),
        ],
      ),
    );
  }
}
