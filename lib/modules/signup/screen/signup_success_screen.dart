import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/layout/unauth_page_layout.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return UnAuthPageLayout(
      appBarTitle: StringConst.signupSuccess,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
              child: Center(
                child: SvgPicture.asset(
                  AppAsset.icBriefcaseWithTick,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: kSizedBoxHeight),
            Text(
              StringConst.signupFreelancerSuccessNotif,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle.copyWith(height: 25.0 / 16),
            ),
            const SizedBox(height: kSizedBoxHeight),
            AppElevatedButton(
              label: StringConst.login,
              elevation: 0,
              onPressed: () {
                AppRouter.replaceAllWithPage(
                  context,
                  AppPages.login,
                  predicate: (route) =>
                      route.settings.name == AppPages.chooseAction.name,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
