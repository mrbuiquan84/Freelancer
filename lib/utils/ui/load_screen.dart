import 'package:flutter/material.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AppAsset.imgLogo,
            width: MediaQuery.of(context).size.width * 259 / 375,
            fit: BoxFit.fitWidth,
          ),
          Image.asset(AppAsset.imgLoading),
        ],
      ),
    );
  }
}
