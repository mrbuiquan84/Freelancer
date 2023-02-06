import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/load_more_widget.dart';
import 'package:freelancer/common/widgets/load_widget.dart';
import 'package:freelancer/common/widgets/status_container.dart';
import 'package:freelancer/common/widgets/text_with_seemore_trailing.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/job/bloc/job_detail_bloc.dart';
import 'package:freelancer/modules/profile/bloc/price_project_bloc/price_project_bloc.dart';
import 'package:freelancer/modules/profile/models/get_price_project_result.dart';
import 'package:freelancer/utils/data/set_price_project_status.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../router/app_pages.dart';
import '../../../router/app_router.dart';
import '../../../utils/data/error_state_action.dart';
import '../../../utils/data/load_state_actions.dart';
import '../../../utils/ui/show_load_dialog.dart';
import '../../../utils/ui/show_toast.dart';
import '../bloc/price_project_bloc/price_project_state.dart';

class SetPriceProjectScreen extends StatelessWidget {
  const SetPriceProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PriceProject> priceProject = [];
    final priceProjectBloc = context.read<PriceProjectBloc>();

    Widget _itemBuilder(BuildContext context, int index) {
      var item = priceProject[index];
      // return SetPriceProjectCard(
      //   project: item,
      //   padding: EdgeInsets.symmetric(
      //     horizontal: kPadding(context),
      //     vertical: 10.0,
      //   ),
      // );
      return BlocProvider.value(
          value: priceProjectBloc,
          child: SetPriceProjectCard(
            project: item,
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 10.0,
            ),
          ));
    }

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.setPriceProjects.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: kScaffoldBodyVerticalPadding,
          ),
          color: AppColors.white,
          width: double.infinity,
          child: BlocConsumer<PriceProjectBloc, PriceProjectState>(
            bloc: priceProjectBloc,
            listener: (_, state) {
              if (state is PriceProjectLoadState &&
                  state.onLoad == LoadStateActions.popup) {
                showLoadDialog(context);
              } else if (state is PriceProjectErrorState &&
                  state.action == ErrorStateActions.alert) {
                showToast(state.error.toString());
              }
            },
            buildWhen: (_, state) {
              var c1 = state.runtimeType == PriceProjectState;
              var c2 = (state is PriceProjectErrorState &&
                  state.action == ErrorStateActions.rebuild);
              var c3 = (state is PriceProjectLoadState &&
                  state.onLoad == LoadStateActions.rebuild);
              var rebuildCondition = c1 || c2 || c3;
              return rebuildCondition;
            },
            builder: (_, state) {
              if (state is PriceProjectErrorState) {
                return ErrorActionWidget(
                  error: state.error.toString(),
                  onPressed: priceProjectBloc.initLoad,
                );
              } else if (state is PriceProjectLoadState) {
                return const LoadWidget();
              }
              priceProject = priceProjectBloc.jobs;
              // return LoadMoreWidget(
              //   onLoad: () => priceProjectBloc.getPriceProject(
              //     onError: ErrorStateActions.alert,
              //     onLoad: LoadStateActions.none,
              //   ),
              return RefreshIndicator(
                onRefresh: () => priceProjectBloc.getPriceProject(),
                child: SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: priceProject.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: _itemBuilder,
                  ),
                ),
              );
            },
          )),
    );
  }
}

class SetPriceProjectCard extends StatelessWidget {
  const SetPriceProjectCard({
    Key? key,
    required this.project,
    this.padding,
  }) : super(key: key);
  final PriceProject project;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    var expriedDateText =
        project.dateEnd.compareTo(DateTime.parse(DateTime.now().toString())) >=
                0
            ? project.dateEnd.format()
            : 'Đã hết hạn';
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
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            iconColor: AppColors.red,
            text: project.salary,
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
                  text: expriedDateText,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    height: 24.0 / 15.0,
                    color: AppColors.textColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
              text: StringConst.setPriceRange + ': ',
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                height: 24.0 / 15.0,
                color: AppColors.gray,
              ),
              children: [
                TextSpan(
                  text: project.salary,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    height: 24.0 / 15.0,
                    color: AppColors.red,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: kSizedBoxHeight),
          Center(
            child: StatusContainer(
              // value: project.status,
              value:
                  SetPriceProjectStatus.fromId(project.status == "Chờ chấp nhận"
                      ? 0
                      : project.status == "Từ chối"
                          ? 1
                          : 2),
              group: SetPriceProjectStatus.statuses,
              colors: const [
                AppColors.orangeAccent,
                AppColors.red,
                AppColors.irisBlue,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
