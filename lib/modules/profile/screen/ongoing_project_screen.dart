import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/list_chip.dart';
import 'package:freelancer/common/widgets/layout/rating_bar.dart';
import 'package:freelancer/common/widgets/load_more_widget.dart';
import 'package:freelancer/common/widgets/load_widget.dart';
import 'package:freelancer/common/widgets/status_container.dart';
import 'package:freelancer/common/widgets/text_with_seemore_trailing.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/job/bloc/job_detail_bloc.dart';
import 'package:freelancer/modules/profile/bloc/ongoing_project_bloc/ongoing_project_bloc.dart';
import 'package:freelancer/modules/profile/models/get_saved_ongoing_project_result.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/data/ongoing_project_status.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_load_dialog.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../bloc/ongoing_project_bloc/ongoing_project_state.dart';

class OngoingProjectScreen extends StatelessWidget {
  const OngoingProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var data = OngoingProject.data;

    List<FlcGoingJob> goingJob = [];
    final onGoingProjectBloc = context.read<OngoingProjectBloc>();

    Widget _itemBuilder(BuildContext context, int index) {
      var item = goingJob[index];
      return BlocProvider.value(
        value: onGoingProjectBloc,
        child: OngoingProjectCard(
          project: item,
          padding: EdgeInsets.symmetric(
            horizontal: kPadding(context),
            vertical: 10.0,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.ongoingProjects.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: kScaffoldBodyVerticalPadding,
        ),
        color: AppColors.white,
        width: double.infinity,
        // child: ListView.builder(
        //   itemCount: goingJob.length,
        //   itemBuilder: _itemBuilder,
        // ),
        child: BlocConsumer<OngoingProjectBloc, OngoingProjectState>(
          bloc: onGoingProjectBloc,
          listener: (_, state) {
            if (state is OngoingProjectLoadState &&
                state.onLoad == LoadStateActions.popup) {
              showLoadDialog(context);
            } else if (state is OngoingProjectErrorState &&
                state.action == ErrorStateActions.alert) {
              showToast(state.error.toString());
            }
          },
          buildWhen: (_, state) {
            var c1 = state.runtimeType == OngoingProjectState;
            var c2 = (state is OngoingProjectErrorState &&
                state.action == ErrorStateActions.rebuild);
            var c3 = (state is OngoingProjectLoadState &&
                state.onLoad == LoadStateActions.rebuild);
            var rebuildCondition = c1 || c2 || c3;
            return rebuildCondition;
          },
          builder: (_, state) {
            if (state is OngoingProjectErrorState) {
              return ErrorActionWidget(
                error: state.error.toString(),
                onPressed: onGoingProjectBloc.initLoad,
              );
            } else if (state is OngoingProjectLoadState) {
              return const LoadWidget();
            }
            goingJob = onGoingProjectBloc.jobs;
            // return LoadMoreWidget(
            //   onLoad: () => onGoingProjectBloc.getOngoingProject(
            //     onError: ErrorStateActions.alert,
            //     onLoad: LoadStateActions.none,
            //   ),
            return RefreshIndicator(
              onRefresh: () => onGoingProjectBloc.getOngoingProject(),
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: goingJob.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: _itemBuilder,
                ),
              ),
            );
            // );
          },
        ),
      ),
    );
  }
}

class OngoingProjectCard extends StatelessWidget {
  const OngoingProjectCard({
    Key? key,
    required this.project,
    this.padding,
  }) : super(key: key);
  final FlcGoingJob project;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(kBorderRadius20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0.0, 2.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWithClickableTrailing(
              text: project.titleJob,
              onTap: () {
                var jobDetailBloc = JobDetailBloc(project.jobId);
                AppRouter.toPage(
                  context,
                  AppPages.jobDetail,
                  blocValue: jobDetailBloc,
                );
              }),
          IconWithTextWidget(
            iconAsset: AppAsset.icCoin,
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            iconColor: AppColors.red,
            text: project.salaryPermanentNumber,
            textStyle: AppTextStyles.iconWithTextTextStyle
                .copyWith(color: AppColors.red),
          ),
          RichText(
            text: TextSpan(
              text: StringConst.expiredDate + ': ',
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                height: 24.0 / 15.0,
                color: AppColors.gray,
              ),
              children: [
                TextSpan(
                  text: project.dateBidEnd.format(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    height: 24.0 / 15.0,
                    color: AppColors.textColor,
                  ),
                )
              ],
            ),
          ),
          ListChip(values: project.listSkill, limit: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBar(
                rating: double.parse(project.star),
                unRatingIcon: SvgPicture.asset(
                  AppAsset.icStar,
                  color: AppColors.unRatedIconColor,
                ),
              ),
              StatusContainer(
                value: OngoingProjectStatus.fromId(
                    project.status == 'Đang thực hiện'
                        ? 0
                        : project.status == 'Không hoàn thành'
                            ? 1
                            : 2),
                group: OngoingProjectStatus.statuses,
                colors: const [
                  AppColors.orangeAccent,
                  AppColors.red,
                  AppColors.irisBlue,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class OngoingProject {
//   final String title;
//   final String price;
//   final DateTime expriredDate;
//   final List<String> cates;
//   final double rating;
//   final int status;

//   OngoingProject({
//     required this.title,
//     required this.price,
//     required this.expriredDate,
//     required this.cates,
//     required this.rating,
//     required this.status,
//   });

  // static final data = [
  //   OngoingProject(
  //     title: 'Thiết kế logo cho áo đồng phục công ty theo gợi ý.',
  //     price: '3.000.000 VNĐ',
  //     expriredDate: DateTime.now(),
  //     cates: [
  //       'SEO',
  //       'Bán hàng',
  //       'Quảng cáo' 'Bán hàng',
  //       'Quảng cáo',
  //     ],
  //     rating: 3.0,
  //     status: 0,
  //   ),
  //   OngoingProject(
  //     title: 'Thiết kế logo cho áo đồng phục công ty theo gợi ý.',
  //     price: '3.000.000 VNĐ',
  //     expriredDate: DateTime.now(),
  //     cates: [
  //       'SEO',
  //       'Bán hàng',
  //       'Quảng cáo' 'Bán hàng',
  //       'Quảng cáo',
  //     ],
  //     rating: 3.0,
  //     status: 1,
  //   ),
  //   OngoingProject(
  //     title: 'Thiết kế logo cho áo đồng phục công ty theo gợi ý.',
  //     price: '3.000.000 VNĐ',
  //     expriredDate: DateTime.now(),
  //     cates: [
  //       'SEO',
  //       'Bán hàng',
  //       'Quảng cáo' 'Bán hàng',
  //       'Quảng cáo',
  //     ],
  //     rating: 3.0,
  //     status: 2,
  //   ),
  // ];
