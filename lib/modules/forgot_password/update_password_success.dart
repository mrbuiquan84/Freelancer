import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/layout/unauth_page_layout.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class UpdatePasswordSuccessScreen extends StatelessWidget {
  const UpdatePasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return UnAuthPageLayout(
      appBarTitle: StringConst.updatePassword.toTitleCase(),
      child: Column(
        children: [
          SvgPicture.asset(AppAsset.icPadlock),
          SizedBox(height: height * 0.05),
          const Text(
            StringConst.updatePasswordSuccessNotif,
            style: AppTextStyles.textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          AppElevatedButton(
            label: StringConst.login,
            onPressed: () {
              AppRouter.backToPage(context, AppPages.login);
            },
          ),
          const SizedBox(height: kSizedBoxHeight),
        ],
      ),
    );
  }
}
