import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/generay_user_info_header.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/job_card.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/empler/bloc/empler_detail_bloc.dart';
import 'package:freelancer/modules/empler/bloc/empler_detail_state.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../utils/data/job_type.dart';

class EmplerScreen extends StatelessWidget {
  const EmplerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    var topPadding = (scrSize.height * 0.4).clamp(0.0, 155.0) + kToolbarHeight;

    buildLocation(String location) => IconWithTextWidget(
          iconAsset: AppAsset.icCircleMouseClicker,
          text: location,
          textStyle: buildIconWithTextTextStyle(),
        );

    buildPhone(String phone) => IconWithTextWidget(
          iconAsset: AppAsset.icCirclePhoneCalling,
          // text: StringConst.loginToSee('SĐT'),
          text: phone,
          textStyle: buildIconWithTextTextStyle(color: AppColors.primaryColor),
        );

    buildEmail(String email) => IconWithTextWidget(
          iconAsset: AppAsset.icCircleEmail,
          // text: StringConst.loginToSee('Email'),
          text: email,
          textStyle: buildIconWithTextTextStyle(color: AppColors.primaryColor),
        );

    var _emplerDetailBloc = context.read<EmplerDetailBloc>();
    var _appRepo = context.read<AppRepo>();

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.recruitment.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      extendBodyBehindAppBar: true,
      body: BlocBuilder(
        bloc: _emplerDetailBloc,
        builder: (context, state) {
          if (state is EmplerDetailLoadDoneState) {
            final empler = state.info;
            final jobs = state.jobs;
            var postedJobText = Padding(
              padding: const EdgeInsets.symmetric(vertical: kSizedBoxHeight),
              child: RichText(
                text: TextSpan(
                  text: StringConst.theseIs,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    height: 24.55 / 18.0,
                    color: AppColors.textColor,
                  ),
                  children: [
                    TextSpan(
                      text: empler.jobsPosted.toString(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        height: 21.09 / 18.0,
                        color: AppColors.orangeAccent,
                      ),
                    ),
                    const TextSpan(
                      text: StringConst.postedJob,
                    ),
                  ],
                ),
              ),
            );
            return Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Image.asset(AppAsset.imgFlcerBackground),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: topPadding),
                      GeneralUserInfoHeader(
                        avatar: empler.avatar,
                        name: empler.name ?? StringConst.nonUpdateError,
                        children: [
                          buildLocation(
                              empler.city ?? StringConst.nonUpdateError),
                          buildPhone(
                              empler.phone ?? StringConst.nonUpdateError),
                          buildEmail(
                              empler.email ?? StringConst.nonUpdateError),
                        ],
                      ),
                      Container(
                        height: 10.0,
                        color: AppColors.lightIrisBlue,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: kPadding(context)),
                        width: double.infinity,
                        color: AppColors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            postedJobText,
                            ...jobs
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: JobCard(
                                      jobType:
                                          JobType.fromId(int.parse(e.jobType)),
                                      jobId: e.id,
                                      detail: true,
                                      emplerId: _emplerDetailBloc.id.toString(),
                                      skillNames: e.namesSkill,
                                      jobTitle: e.titleJob,
                                      salary:
                                          Salary.fromJob(e).toSalaryString(),
                                      emplerName: empler.name,
                                      location: e.citName,
                                      expDate: e.dateBidEnd,
                                      skillIds: e.skillId.split(',').map((e) {
                                        return JobCate.fromId(
                                          e,
                                          list: _appRepo.jobCates,
                                        ).id;
                                      }).toList(),
                                      favorite: false,
                                      jobCate: JobCate.fromId(
                                        e.skillId,
                                        list: _appRepo.jobCates,
                                      ).toString(),
                                      emplerLogo: empler.avatar,
                                      orders: e.recordsDid.toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                            const SizedBox(height: 2 * kSizedBoxHeight),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state is EmplerDetailErrorState) {
            return ErrorActionWidget(
              error: state.error,
              onPressed: () {
                _emplerDetailBloc.loadData(id: _emplerDetailBloc.id);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  TextStyle buildIconWithTextTextStyle({Color? color}) {
    return AppTextStyles.iconWithTextTextStyle.copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 21.82 / 16.0,
      color: color,
    );
  }
}
