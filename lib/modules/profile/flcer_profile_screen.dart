import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/popup/confirm_popup.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/model/post_flcer_info_result.dart';
import 'package:freelancer/modules/profile/bloc/ongoing_project_bloc/ongoing_project_bloc.dart';
import 'package:freelancer/modules/profile/bloc/price_project_bloc/price_project_bloc.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_bloc.dart';
import 'package:freelancer/modules/profile/change_password_bloc/change_password_bloc.dart';
import 'package:freelancer/modules/profile/screen/general_management_page.dart';
import 'package:freelancer/modules/profile/widget/field_outlined_button.dart';
import 'package:freelancer/modules/profile/widget/user_list_tile.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlcerProfileScreen extends StatelessWidget {
  const FlcerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthBloc>();

    final Info info = CurrentUser.of(context).currentFlcer!.info;

    var flcerFields = [
      StringConst.generalManagement,
      StringConst.ongoingProjects,
      StringConst.setPriceProjects,
      StringConst.savedProjects,
      StringConst.changePassword,
      StringConst.logout,
    ];

    var flcerIconFields = [
      AppAsset.icGridFill,
      AppAsset.icProjectorScreen,
      AppAsset.icTelegramPlane,
      AppAsset.icHeart,
      AppAsset.icPassword,
      AppAsset.icLogout,
    ];

    List<Function()> onPresseds = [
      () => AppRouter.toPage(
            context,
            AppPages.flcerGeneralManagement,
          ),
      () {
        final OngoingProjectBloc ongoingProjectBloc = OngoingProjectBloc();
        AppRouter.toPage(
          context,
          AppPages.ongoingProjectScreen,
          blocValue: ongoingProjectBloc,
        );
      },
      () {
        final PriceProjectBloc priceProjectBloc = PriceProjectBloc();
        AppRouter.toPage(
          context,
          AppPages.setPriceProjectScreen,
          blocValue: priceProjectBloc,
        );
      },
      () {
        final SavedProjectBloc savedProjectBloc = SavedProjectBloc();
        AppRouter.toPage(
          context,
          AppPages.flcerSavedProjects,
          blocValue: savedProjectBloc,
        );
      },
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

    var flcerView = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kPadding(context),
          vertical: kPadding(context),
        ),
        child: Column(
          children: [
            UserListTile(
              joinDate: info.birthday,
              location: info.city,
              name: info.name,
              showCameraButton: true,
              avatar: info.srcAvatar,
            ),
            const SizedBox(height: kSizedBoxHeight),
            ...List.generate(
              flcerFields.length,
              (index) => FieldOutlinedButton(
                color: index % 2 == 0
                    ? AppColors.primaryColor
                    : AppColors.orangeAccent,
                iconAsset: flcerIconFields[index],
                fieldName: flcerFields[index],
                onPressed: onPresseds[index],
              ),
            ).toList(),
          ],
        ),
      ),
    );
    return flcerView;
  }
}
