import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/widget/appbar_with_logo.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = Text(
      StringConst.selectAccount,
      style: AppTextStyles.appbarTitleTxtStyle,
    );
    final buttonWidth =
        title.getSize().width + (30.0 - kButtonHorizontalPadding) * 2;

    return Scaffold(
      appBar: AppBarWithLogo(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              title,
              const SizedBox(height: kSizedBoxHeight),
              _buildAccount(
                context,
                imageAsset: AppAsset.imgFreelancerLogo,
                buttonLabel: StringConst.candidate,
                buttonWidth: buttonWidth,
                onPressed: () {
                  CurrentUser.of(context).userType = UserType.freelancer;
                  AppRouter.toPage(
                    context,
                    AppPages.chooseAction,
                  );
                },
              ),
              const SizedBox(height: kSizedBoxHeight),
              _buildAccount(
                context,
                imageAsset: AppAsset.imgRecruitmentLogo,
                buttonLabel: StringConst.recruitment,
                buttonWidth: buttonWidth,
                onPressed: () {
                  CurrentUser.of(context).userType = UserType.employer;
                  AppRouter.toPage(
                    context,
                    AppPages.chooseAction,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAccount(
    BuildContext context, {
    required String imageAsset,
    required String buttonLabel,
    VoidCallback? onPressed,
    double? buttonWidth,
  }) {
    return Column(
      children: [
        Image.asset(imageAsset),
        const SizedBox(height: kSizedBoxHeight),
        AppOutlinedButton(
          elevation: kElevation,
          backgroundColor: AppColors.white,
          height: 45.0,
          child: buttonLabel,
          width: buttonWidth,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
