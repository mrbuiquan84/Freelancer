import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/app_chip.dart';
import 'package:freelancer/common/widgets/app_network_image.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/header.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/model/post_flcer_info_result.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/widget/column_of_general_management_info.dart';
import 'package:freelancer/modules/profile/widget/user_list_tile.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class FlcerGeneralManagementPage extends StatelessWidget {
  const FlcerGeneralManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flcerInfoBloc = CurrentUser.of(context).flcerProfileBloc!;
    final info = flcerInfoBloc.flcerInfo!.info;

    buildTextStyle({
      double height = 24.59,
      Color color = AppColors.textColor,
    }) =>
        TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          height: height / 16.0,
          color: color,
        );

    Widget buildExpectedJobFieldRow({
      required String title,
      required String data,
    }) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: RichText(
            text: TextSpan(
              text: '- $title: ',
              style: buildTextStyle(),
              children: [
                TextSpan(
                  text: data,
                  style: buildTextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        );

    Widget buildContainer({
      required Widget child,
    }) {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: kPadding(context),
        ),
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(kBorderRadius20),
          border: Border.all(
            color: const Color(0xFFDBDBDB),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black15,
              offset: const Offset(0.0, 2.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: child,
      );
    }

    var children2 = [
      UserListTile(
        avatar: info.srcAvatar,
        joinDate: info.createdAt,
        location: info.city,
        name: info.name,
        heroKeyTag: StringConst.heroKeyTag,
      ),
      ColumnOfGeneralManagementInfo(
        dob: info.birthday,
        email: info.email,
        gender: info.sex,
        phone: info.phone,
      ),
      const SizedBox(height: kSizedBoxHeight),
      AppElevatedButton(
        label: StringConst.updateProfile.toTitleCase(),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 30.0,
        ),
        onPressed: () {
          AppRouter.toPage(
            context,
            AppPages.updateProfilePage,
          );
        },
      ),
      const SizedBox(height: 5.0),
    ];
    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.generalManagement.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: kScaffoldBodyVerticalPadding),
        child: Container(
          color: AppColors.white,
          width: double.infinity,
          child: BlocBuilder(
              bloc: flcerInfoBloc,
              builder: (context, state) {
                var _appRepo = context.read<AppRepo>();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      buildContainer(
                        child: Column(
                          children: children2,
                        ),
                      ),
                      buildContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Header(
                              header: StringConst.introYourself,
                              padding: EdgeInsets.only(bottom: 5.0),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '${StringConst.expWorking}: ',
                                style: buildTextStyle(),
                                children: [
                                  TextSpan(
                                    text: info.skillYear,
                                    style: buildTextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                info.userDes.toString(),
                                style: buildTextStyle(height: 31.71),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  StringConst.seeMore,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.italic,
                                    height: 19.1 / 14.0,
                                    color: AppColors.orangeAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Header(
                              header: StringConst.expectedJob,
                              padding: EdgeInsets.only(bottom: 10.0),
                            ),
                            buildExpectedJobFieldRow(
                              title: StringConst.career,
                              data: info.userJob,
                            ),
                            buildExpectedJobFieldRow(
                              title: StringConst.workingForm,
                              data: info.formOfWork,
                            ),
                            buildExpectedJobFieldRow(
                              title: StringConst.expectedJob,
                              data: info.categoryId
                                  .split(',')
                                  .map((e) =>
                                      JobCate.fromId(e, list: _appRepo.jobCates)
                                          .toString())
                                  .join(', '),
                            ),
                            buildExpectedJobFieldRow(
                              title: StringConst.expectedLocation,
                              data: info.workPlace.toString(),
                            ),
                            buildExpectedJobFieldRow(
                              title: StringConst.expectedSalary,
                              data: Salary.fromProperties(
                                salaryType: info.salaryType,
                                salaryEstimateNumber1:
                                    info.salaryEstimateNumber1,
                                salaryEstimateNumber2:
                                    info.salarySalaryEstimateNumber2,
                                salaryEstimatesDate: info.salaryEstimatesDate,
                                salaryPermanentDate: info.salaryPermanentDate,
                                salaryPermanentNumber:
                                    info.salaryPermanentNumber,
                              ).toSalaryString(),
                            ),
                          ],
                        ),
                      ),
                      buildContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Header(
                              header: StringConst.skill,
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Wrap(
                              runSpacing: 10.0,
                              children: info.listSkill
                                  .map((e) => AppChip(label: e.toString()))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      buildContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Header(
                              header: StringConst.capacityProfile,
                              padding: EdgeInsets.only(bottom: 15.0),
                            ),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 2,
                                mainAxisSpacing: kSizedBoxWidth,
                                crossAxisSpacing: kSizedBoxWidth,
                              ),
                              shrinkWrap: true,
                              itemCount: info.proficiency.length,
                              itemBuilder: (_, index) {
                                return ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  child: AppNetworkImage(
                                    imageUrl: info.proficiency[index].source!,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: kSizedBoxHeight),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
