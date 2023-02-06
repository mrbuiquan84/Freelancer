import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/core/constants/string_constants.dart';

class SearchAppBar extends AppAppBar {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      title: const Text(
        StringConst.search,
        textHeightBehavior: TextHeightBehavior(
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
      centerTitle: true,
    );
  }
}
