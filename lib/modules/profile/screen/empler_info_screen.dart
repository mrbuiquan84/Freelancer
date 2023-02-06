import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/widget/column_of_general_management_info.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:http/http.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../widget/user_list_tile.dart';

class EmplerInfoScreen extends StatelessWidget {
  const EmplerInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emplerInfoBloc = CurrentUser.of(context).emplerProfileBloc!;
    final info = emplerInfoBloc.emplerInfo!;

    var children2 = [
      UserListTile(
        avatar: info.avatar,
        name: info.name,
        location: info.city,
        joinDate: info.createdAt,
        showCameraButton: true,
      ),
      ColumnOfGeneralManagementInfo(
        dob: info.birthday,
        email: info.email,
        gender: info.sex,
        phone: info.phone,
      ),
      const SizedBox(height: kSizedBoxHeight),
    ];
    return Scaffold(
        appBar: AppAppBar(
          title: Text(StringConst.accountManagement.toTitleCase()),
          centerTitle: true,
        ),
        backgroundColor: AppColors.lightIrisBlue,
        body: Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius20),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black15,
                  offset: const Offset(0.0, 2.0),
                  blurRadius: 8.0,
                )
              ],
            ),
            child: Column(children: [
              BlocBuilder(
                  bloc: emplerInfoBloc,
                  builder: (context, state) {
                    var _appRepo = context.read<AppRepo>();
                    return SingleChildScrollView(
                      child: Column(
                        children: children2,
                      ),
                    );
                  }),
              Expanded(
                child: Container(),
              ),
              AppElevatedButton(
                label: StringConst.updateProfile.toTitleCase(),
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 30.0,
                ),
                onPressed: () {
                  AppRouter.toPage(context, AppPages.updateInfoEmpler,);
                },
              ),
            ])));
  }
}
