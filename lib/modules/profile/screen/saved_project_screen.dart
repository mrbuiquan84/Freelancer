import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/list_chip.dart';
import 'package:freelancer/common/widgets/load_more_widget.dart';
import 'package:freelancer/common/widgets/load_widget.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/common/widgets/popup/load_popup.dart';
import 'package:freelancer/common/widgets/status_container.dart';
import 'package:freelancer/common/widgets/text_with_seemore_trailing.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/job/bloc/job_detail_bloc.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_bloc.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_state.dart';
import 'package:freelancer/modules/profile/models/get_saved_ongoing_project_result.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_load_dialog.dart';
import 'package:freelancer/utils/ui/show_toast.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/popup/set_price_popup.dart';
import '../../flcer_order_job/bloc/flcer_order_job_bloc.dart';

class SavedProjectScreen extends StatelessWidget {
  const SavedProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlcSaveJob> savedJobs = [];
    final savedProjectBloc = context.read<SavedProjectBloc>();
    var deleteButton = SizedBox(
      height: 35.0,
      width: 35.0,
      child: OutlinedButton(
        onPressed: () async {},
        child: Center(
          child: SvgPicture.asset(
            AppAsset.icDeleteFill,
            color: AppColors.red,
            height: 35.0,
            width: 35.0,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(
            color: AppColors.red,
          ),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );

    Widget _itemBuilder(BuildContext context, FlcSaveJob item) {
      // var item = savedJobs[index];
      return BlocProvider.value(
        value: savedProjectBloc,
        child: Dismissible(
          background: deleteButton,
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (_) => AppDialog(
                      title: 'Xác nhận xóa việc làm đã lưu này',
                      titleTextAlign: TextAlign.center,
                      padding: const EdgeInsets.all(20),
                      centerTitle: true,
                      content: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SvgPicture.asset(
                              AppAsset.icDeleteFill,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              color: AppColors.errorColor,
                            ),
                          ),
                          CoupleBottomOutlinedAndElevatedButtons(
                            firstLabel: StringConst.confirm,
                            secondaryLabel: StringConst.cancel,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            onPressedFirstButton: () {},
                            onPressedSecondaryButton: () =>
                                AppRouter.back(context),
                          ),
                        ],
                      ),
                    ));
          },
          key: Key(item.toString()),
          child: SavedProjectCard(
            project: item,
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 10.0,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.savedProjects.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Container(
        // margin: const EdgeInsets.only(
        //   top: kScaffoldBodyVerticalPadding,
        // ),
        color: AppColors.white,
        width: double.infinity,
        child: BlocConsumer<SavedProjectBloc, SavedProjectState>(
          bloc: savedProjectBloc,
          listener: (_, state) {
            if (state is SavedProjectLoadState &&
                state.onLoad == LoadStateActions.popup) {
              showLoadDialog(context);
            } else if (state is SavedProjectErrorState &&
                state.action == ErrorStateActions.alert) {
              showToast(state.error.toString());
            }
          },
          buildWhen: (_, state) {
            var c1 = state.runtimeType == SavedProjectState;
            var c2 = (state is SavedProjectErrorState &&
                state.action == ErrorStateActions.rebuild);
            var c3 = (state is SavedProjectLoadState &&
                state.onLoad == LoadStateActions.rebuild);
            var rebuildCondition = c1 || c2 || c3;
            return rebuildCondition;
          },
          builder: (_, state) {
            if (state is SavedProjectErrorState) {
              return ErrorActionWidget(
                error: state.error.toString(),
                onPressed: savedProjectBloc.getSavedProject(),
              );
            } else if (state is SavedProjectLoadState) {
              return const LoadWidget();
            }
            savedJobs = savedProjectBloc.jobs;
            return RefreshIndicator(
              onRefresh: () => savedProjectBloc.getSavedProject(),
              // child: ListView.builder(
              //   itemCount: savedJobs.length,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: _itemBuilder,
              // ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: kSizedBoxHeight),
                  Container(
                    color: AppColors.white,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                        //   child: CateHeader(
                        //     header: StringConst.jobFlcerByProject.toTitleCase(),
                        //     onPressedArrowButton: () {
                        //       _toListJobByJobTypeScreen(jobType: JobType.projectType);
                        //     },
                        //   ),
                        // ),
                        ...savedJobs.map((e) => _itemBuilder(context, e))
                      ],
                    ),
                  )
                ],
              )),
            );
          },
        ),
      ),
    );
  }
}

class SavedProjectCard extends StatefulWidget {
  const SavedProjectCard({
    Key? key,
    required this.project,
    this.padding,
  }) : super(key: key);
  final FlcSaveJob project;
  final EdgeInsetsGeometry? padding;

  @override
  State<SavedProjectCard> createState() => _SavedProjectCardState();
}

class _SavedProjectCardState extends State<SavedProjectCard> {
  late final SavedProjectBloc _savedProjectBloc;

  @override
  void initState() {
    super.initState();
    _savedProjectBloc = context.read<SavedProjectBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var deleteButton = SizedBox(
      height: 35.0,
      width: 35.0,
      child: OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: _savedProjectBloc,
              child: DeleteSavedJobAlertPopup(
                projectId: widget.project.id,
              ),
            ),
          );
        },
        child: Center(
          child: SvgPicture.asset(
            AppAsset.icDeleteFill,
            color: AppColors.red,
            height: 35.0,
            width: 35.0,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(
            color: AppColors.red,
          ),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );

    var price = Salary.fromProperties(
      salaryType: widget.project.salaryType,
      salaryPermanentNumber: widget.project.salaryPermanentNumber,
      salaryEstimateNumber1: widget.project.salaryEstimateNumber1,
      salaryEstimateNumber2: widget.project.salarySalaryEstimateNumber2,
    ).toSalaryString();

    return BlocBuilder(
      bloc: _savedProjectBloc,
      builder: (context, state) {
        if (state is SavedProjectDeleteSuccessState &&
            state.deletedJobId == widget.project.id) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: widget.padding,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width -
                      2 * kPadding(context) -
                      10.0,
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(12.0),
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
                          text: widget.project.titleJob,
                          onTap: () {
                            var jobDetailBloc =
                                JobDetailBloc(widget.project.id);
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
                        text: price,
                        textStyle: AppTextStyles.iconWithTextTextStyle
                            .copyWith(color: AppColors.red),
                      ),
                      RichText(
                        text: TextSpan(
                          text: StringConst.lastTimeToSetPrice + ': ',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            height: 24.0 / 15.0,
                            color: AppColors.gray,
                          ),
                          children: [
                            TextSpan(
                              text: widget.project.dateBidEnd.format(),
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
                      const SizedBox(height: 10.0 - 5.0),
                      ListChip(values: widget.project.listSkill, limit: 3),
                      const SizedBox(height: kSizedBoxHeight - 5.0),
                      Center(
                        child: StatusContainer(
                          onTap: () {
                            var orderBloc = FlcerOrderJobBloc();
                            showDialog(
                              context: context,
                              builder: (_) => Center(
                                child: BlocProvider.value(
                                  value: orderBloc,
                                  child: SetPricePopup(
                                    expDate: DateFormat('yyyy-MM-dd')
                                        .format(widget.project.dateBidEnd)
                                        .toString(),
                                    jobId: widget.project.id,
                                    jobTitle: widget.project.titleJob,
                                  ),
                                ),
                              ),
                            );
                          },
                          value: StringConst.setPrice,
                          group: const [StringConst.setPrice],
                          colors: const [AppColors.primaryColor],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: deleteButton,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DeleteSavedJobAlertPopup extends StatefulWidget {
  const DeleteSavedJobAlertPopup({
    Key? key,
    required this.projectId,
  }) : super(key: key);
  final String projectId;

  @override
  State<DeleteSavedJobAlertPopup> createState() =>
      _DeleteSavedJobAlertPopupState();
}

class _DeleteSavedJobAlertPopupState extends State<DeleteSavedJobAlertPopup> {
  late final SavedProjectBloc _savedProjectBloc;
  bool? _isConfirm;

  @override
  void initState() {
    super.initState();
    _savedProjectBloc = context.read<SavedProjectBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var alertDialog = AppDialog(
      title: 'Xác nhận xóa việc làm đã lưu này ?',
      titleTextAlign: TextAlign.center,
      padding: const EdgeInsets.all(20),
      centerTitle: true,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SvgPicture.asset(
              AppAsset.icDeleteFill,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              color: AppColors.errorColor,
            ),
          ),
          CoupleBottomOutlinedAndElevatedButtons(
            firstLabel: StringConst.confirm,
            secondaryLabel: StringConst.cancel,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            onPressedFirstButton: () {
              _savedProjectBloc.deleteSavedJob(widget.projectId);
              setState(() {
                _isConfirm = true;
              });
            },
            onPressedSecondaryButton: () => AppRouter.back(context),
          ),
        ],
      ),
    );

    var loadingDialog = const LoadPopup();

    return BlocListener(
      bloc: _savedProjectBloc,
      listener: (_, state) {
        if (state is SavedProjectDeleteSuccessState) {
          AppRouter.back(context);
        } else if (state is SavedProjectErrorState &&
            state.action == ErrorStateActions.alert &&
            mounted) {
          AppRouter.back(context);
        }
      },
      child: _isConfirm == null
          ? alertDialog
          : (_isConfirm! ? loadingDialog : const SizedBox.shrink()),
    );
  }
}
