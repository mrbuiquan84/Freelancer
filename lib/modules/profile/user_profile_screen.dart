import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/empler.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/help_text_button.dart';
import 'package:freelancer/common/widgets/popup/confirm_popup.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/model/empler_info.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/empler_general_bloc.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_bloc.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_bloc.dart';
import 'package:freelancer/modules/profile/change_password_bloc/change_password_bloc.dart';
import 'package:freelancer/modules/profile/flcer_profile_screen.dart';
import 'package:freelancer/modules/profile/had_set_price_bloc/had_set_price_bloc.dart';
import 'package:freelancer/modules/profile/screen/posted_job_screen.dart';
import 'package:freelancer/modules/profile/widget/field_outlined_button.dart';
import 'package:freelancer/modules/profile/widget/user_list_tile.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_route_observer.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import 'bloc/empler_profile_bloc/empler_profile_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _auth = AuthState.authenticated;
    // var _userType = UserType.freelancer;
    var authBloc = context.read<AuthBloc>();
    var _userType = CurrentUser.of(context).userType;

    var scrSize = MediaQuery.of(context).size;

    var emplerIconFields = [
      AppAsset.icGridFill,
      AppAsset.icAddTab,
      AppAsset.icAccountService,
      AppAsset.icAccount,
      AppAsset.icPassword,
      AppAsset.icLogout,
    ];

    var emplerFields = [
      StringConst.generalManagement,
      StringConst.postedJob,
      StringConst.flcerManagement,
      StringConst.accountInfo,
      StringConst.changePassword,
      StringConst.logout,
    ];

    final Widget body;
    var unauthView = SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(AppAsset.imgProfileInterface),
          const SizedBox(height: kSizedBoxHeight),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: scrSize.width * 0.2),
            child: AppElevatedButton(
              label: StringConst.login,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              labelTextStyle: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                height: 29.95 / 17.0,
                color: AppColors.white,
              ),
              onPressed: () {},
              primary: AppColors.orangeAccent,
              width: double.infinity,
            ),
          ),
          HelpTextButton(
            header: StringConst.notHaveAccount,
            label: StringConst.loginNow,
            headerTextStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              height: 28.0 / 15.0,
              color: AppColors.primaryColor,
            ),
            padding: EdgeInsets.zero,
            onPressed: () {},
          )
        ],
      ),
    );
    List<Function()> onPresseds = [
      () => AppRouter.toPage(
            context,
            AppPages.emplerGeneralManagement,
            blocValue: EmplerGeneralBloc(),
          ),
      () => {
            AppRouter.toPage(context, AppPages.postedJob,
                blocValue: PostedJobBloc()),
          },
      () => AppRouter.toPage(
            context,
            AppPages.emplerFlcerManagement,
          ),
      () => AppRouter.toPage(
            context,
            AppPages.emplerInfor,
          ),
      () => AppRouter.toPage(
            context,
            AppPages.changePasswordScreen,
            blocValue: ChangePassWordBloc(),
          ),
      () async {
        var confirm = await showDialog(
          context: context,
          builder: (_) => ConfirmPopup(
            title: StringConst.logoutAlert,
            onPressedFirstButton: () => AppRouter.back(context, result: true),
          ),
        );
        if (confirm != null && confirm) {
          return authBloc.logout();
        }
      },
    ];

    // if (_auth == AuthState.unAuthenticate) {
    //   body = unauthView;
    // }  {
    if (_userType == UserType.freelancer) {
      body = const FlcerProfileScreen();
    } else if (_userType == UserType.employer) {
      var emplerView = SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kPadding(context),
            vertical: kPadding(context),
          ),
          child: Column(
            children: [
              UserListTile(
                name:
                    CurrentUser.of(context).emplerProfileBloc!.emplerInfo!.name,
                joinDate: CurrentUser.of(context)
                    .emplerProfileBloc!
                    .emplerInfo!
                    .createdAt,
                location:
                    CurrentUser.of(context).emplerProfileBloc!.emplerInfo!.city,
                point: int.parse(CurrentUser.of(context)
                    .emplerProfileBloc!
                    .emplerInfo!
                    .point),
                showCameraButton: true,
                avatar: CurrentUser.of(context)
                    .emplerProfileBloc!
                    .emplerInfo!
                    .avatar,
              ),
              const SizedBox(height: kSizedBoxHeight),
              ...List.generate(
                emplerFields.length,
                (index) => FieldOutlinedButton(
                  color: index % 2 == 0
                      ? AppColors.primaryColor
                      : AppColors.orangeAccent,
                  iconAsset: emplerIconFields[index],
                  fieldName: emplerFields[index],
                  onPressed: onPresseds[index],
                ),
              ).toList(),
            ],
          ),
        ),
      );
      body = emplerView;
    } else {
      body = unauthView;
    }
    // }

    return Scaffold(
      appBar: AppAppBar(
        backButtonAsLeading: false,
        title: Text(
          StringConst.personalPage.toTitleCase(),
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
