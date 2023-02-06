import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/widgets/app_chip.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/empler_card.dart';
import 'package:freelancer/common/widgets/layout/flcer_card.dart';
import 'package:freelancer/common/widgets/layout/outlined_dotted_border_card.dart';
import 'package:freelancer/common/widgets/load_widget.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/job/bloc/job_detail_bloc.dart';
import 'package:freelancer/modules/job/bloc/job_detail_state.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/data/time.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';
import 'package:intl/intl.dart';

import '../../common/widgets/popup/set_price_popup.dart';
import '../auth/bloc/auth_bloc.dart';
import '../flcer_order_job/bloc/flcer_order_job_bloc.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late final JobDetailBloc _jobDetailBloc = context.read<JobDetailBloc>();
  final ScrollController _scrollController = ScrollController();
  double _maxDy = 64.0;
  final ValueNotifier<double> _dyNotif = ValueNotifier<double>(0);

  final textInsideImageTextStyle = const TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    height: 21.52 / 14.0,
    color: AppColors.white,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listener);
  }

  _listener() {
    var speed = _scrollController.position.activity!.velocity;
    var maxExtent = _scrollController.position.maxScrollExtent;
    _dyNotif.value += speed / 50;
    var direction = _scrollController.position.axisDirection;
    var value = _dyNotif.value;
    if (direction == AxisDirection.down) {
      value -= _maxDy / maxExtent;
    } else if (direction == AxisDirection.up) {
      value += _maxDy / maxExtent;
    }
    _dyNotif.value = value.clamp(-_maxDy, 0);
    // print(speed);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    // DateTime endDid;
    // String jobId;
    // String jobTitle;
    final double imgHeight =
        (scrSize.height * 0.3).clamp(200.0, double.infinity);
    var userType = CurrentUser.of(context).userType;
    return Scaffold(
      appBar: AppAppBar(
        title: const Text(StringConst.jobDetail),
        centerTitle: true,
        elevation: kElevation,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Padding(
        padding: const EdgeInsets.only(
          top: kScaffoldBodyVerticalPadding,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BlocConsumer(
                bloc: _jobDetailBloc,
                listener: (_, state) {
                  if (state is JobDetailErrorState &&
                      state.action == ErrorStateActions.alert) {
                    showToast(state.error);
                  }
                },
                buildWhen: (_, state) =>
                    state is JobDetailDoneState ||
                    state is JobDetailErrorState &&
                        state.action == ErrorStateActions.rebuild ||
                    state is JobDetailLoadState &&
                        state.action == LoadStateActions.rebuild,
                builder: (context, state) {
                  if (state is JobDetailDoneState) {
                    var jobDetail = state.info;
                    var orderedFlcers = state.listsFlc;
                    var sameJobs = state.jobsSame;
                    // jobId = jobDetail.id;
                    // jobTitle = jobDetail.titleJob;
                    // endDid = jobDetail.endDid;

                    var descriptionText = Text(
                      jobDetail.workDes,
                      style: const TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        height: 19.1 / 14.0,
                      ),
                      maxLines: 3,
                    );

                    var buildDescriptionText =
                        LayoutBuilder(builder: (_, constrain) {
                      if (descriptionText.hasTextOverflow()) {
                        return descriptionText;
                      }
                      return descriptionText;
                    });

                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 64),
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: kPadding(context),
                              vertical: 10.0,
                            ),
                            color: AppColors.backgroundColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: imgHeight,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius20),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                    image: const DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        'https://www.freshbooks.com/blog/wp-content/uploads/2017/09/working-capital.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    // height: imgHeight * 0.4,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(kBorderRadius20),
                                        bottomRight:
                                            Radius.circular(kBorderRadius20),
                                      ),
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          Salary.fromJob(jobDetail)
                                              .toSalaryString(),
                                          style: const TextStyle(
                                            fontFamily: AppConst.fontNunito,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.orangeAccent,
                                            height: 28.0 / 18.0,
                                          ),
                                        ),
                                        Text(
                                          '${StringConst.idJob}: ${jobDetail.id}',
                                          style: textInsideImageTextStyle,
                                        ),
                                        Text(
                                          '${StringConst.postedDate}: ${jobDetail.createdAts == null ? StringConst.error : jobDetail.createdAts!.format()}',
                                          style: textInsideImageTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: kSizedBoxHeight,
                                    horizontal: 10.0,
                                  ),
                                  child: Text(
                                    jobDetail.titleJob,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: AppConst.fontNunito,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      height: 25.0 / 20.0,
                                      color: AppColors.darkerIrisBlue,
                                    ),
                                  ),
                                ),
                                OutlinedDottedBorderCard(
                                  child: Column(
                                    children: [
                                      IconWithTextWidget(
                                        iconAsset: AppAsset.icInfo,
                                        text:
                                            '${StringConst.form}: ${jobDetail.workName}',
                                      ),
                                      IconWithTextWidget(
                                        iconAsset: AppAsset.icClock,
                                        text:
                                            '${StringConst.duration}: ${jobDetail.workingTerm} ${Time.fromId(jobDetail.workType)}',
                                      ),
                                      IconWithTextWidget(
                                        iconAsset: AppAsset.icCalendarMonth,
                                        text:
                                            '${StringConst.startDate}: ${jobDetail.startWork.format()}',
                                      ),
                                      IconWithTextWidget(
                                        iconAsset: AppAsset.icSuitcase,
                                        text:
                                            '${StringConst.exps}: ${jobDetail.expName}',
                                      ),
                                      IconWithTextWidget(
                                        iconAsset: AppAsset.icMapsAndFlags,
                                        text:
                                            '${StringConst.location}: ${jobDetail.citName}',
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: kSizedBoxHeight),
                                EmplerCard(
                                  avatar: jobDetail.avatars,
                                  createdAt: jobDetail.createdAt,
                                  location: jobDetail.citName,
                                  name: jobDetail.name,
                                  numOfPostedJobs:
                                      jobDetail.jobsPosted.toString(),
                                  nonAvatarAsset: AppAsset.imgColoredNonAvatar,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: kSizedBoxHeight,
                                  ),
                                  child: Text(
                                    StringConst.jobDescription,
                                    style: TextStyle(
                                      fontFamily: AppConst.fontNunito,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                      height: 24.55 / 18.0,
                                    ),
                                  ),
                                ),
                                buildDescriptionText,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kSizedBoxHeight),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '${StringConst.skill}: ',
                                        style: TextStyle(
                                          fontFamily: AppConst.fontNunito,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          height: 20.46 / 15.0,
                                        ),
                                      ),
                                      const SizedBox(width: kSizedBoxWidth),
                                      Expanded(
                                        child: Wrap(
                                          runSpacing: 10.0,
                                          children: jobDetail.skillName
                                              .split(',')
                                              .map(
                                                (e) => AppChip(
                                                    label: e.toString()),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: kPadding(context),
                              vertical: kSizedBoxHeight,
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LayoutBuilder(
                                  builder: (context, constrain) {
                                    return SizedBox(
                                      width: constrain.maxWidth * 2 / 3,
                                      child: Text(
                                        StringConst.numOfFreelancerAppliedJob(
                                            jobDetail.orderedFlc),
                                        style: AppTextStyles.cateHeaderStyle
                                            .copyWith(
                                          height: 24.55 /
                                              (AppTextStyles.cateHeaderStyle
                                                      .fontSize ??
                                                  18.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ...orderedFlcers
                                    .map(
                                      (flcer) => FlcerApplyJobCard(
                                        price: flcer.salary,
                                        nonAvatarAsset: AppAsset.imgUser,
                                        flcerId: '',
                                        flcerName: flcer.name,
                                        skills: flcer.listsSkill,
                                        userJob: flcer.userJob,
                                        imgSize: 60,
                                        rating: null,
                                      ),
                                    )
                                    .toList(),
                                const SizedBox(height: kSizedBoxHeight),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius10),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 10.0,
                                        color: AppColors.shadow10,
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          color: AppColors.orangeAccent,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6.0,
                                          ),
                                          child: const Text(
                                            StringConst.similarlyJob,
                                            style: TextStyle(
                                              fontFamily: AppConst.fontNunito,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                              height: 27.66 / 18.0,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        ...sameJobs
                                            .map(
                                              (job) => Material(
                                                color: AppColors.white,
                                                child: InkWell(
                                                  splashColor:
                                                      AppColors.lightIrisBlue,
                                                  onTap: () {
                                                    var bloc =
                                                        JobDetailBloc(job.id);
                                                    AppRouter.toPage(
                                                      context,
                                                      AppPages.jobDetail,
                                                      blocValue: bloc,
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20.0,
                                                      top: 20.0,
                                                      bottom: 10.0,
                                                    ),
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color:
                                                              AppColors.gray4,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          job.titleJob,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: AppConst
                                                                .fontNunito,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height:
                                                                21.82 / 16.0,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10.0),
                                                        IconWithTextWidget(
                                                          iconAsset:
                                                              AppAsset.icBag,
                                                          text:
                                                              job.categoryName,
                                                        ),
                                                        IconWithTextWidget(
                                                          iconAsset:
                                                              AppAsset.icMoney,
                                                          text: Salary.fromJob(
                                                                  job)
                                                              .toSalaryString(),
                                                          textStyle: AppTextStyles
                                                              .iconWithTextTextStyle
                                                              .copyWith(
                                                            color:
                                                                AppColors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          userType == UserType.freelancer
                              ? ValueListenableBuilder<double>(
                                  valueListenable: _dyNotif,
                                  builder: (context, dy, child) {
                                    double y = dy.clamp(-_maxDy, 0);
                                    return Positioned(
                                      bottom: y,
                                      child: child!,
                                    );
                                  },
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: scrSize.width,
                                    ),
                                    child:
                                        CoupleBottomOutlinedAndElevatedButtons(
                                      // height: 64,
                                      firstLabel: StringConst.cancel,
                                      secondaryLabel:
                                          StringConst.setPrice.toUpperCase(),
                                      onPressedFirstButton: () =>
                                          AppRouter.back(context),
                                      onPressedSecondaryButton: () {
                                        var orderBloc = FlcerOrderJobBloc();
                                        showDialog(
                                          context: context,
                                          builder: (_) => Center(
                                            child: BlocProvider.value(
                                              value: orderBloc,
                                              child: SetPricePopup(
                                                expDate: DateFormat(
                                                        'yyyy-MM-dd')
                                                    .format(jobDetail.endDid)
                                                    .toString(),
                                                jobId: jobDetail.id,
                                                jobTitle: jobDetail.titleJob,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      boxDecoration: BoxDecoration(
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.darkGray1
                                                .withOpacity(0.25),
                                            offset: const Offset(0.0, -0.5),
                                            blurRadius: 4.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(height: 10.0),
                        ],
                      ),
                    );
                  } else if (state is JobDetailErrorState) {
                    return ErrorActionWidget(
                      error: state.error,
                      onPressed: () => _jobDetailBloc.loadJobDetail(),
                    );
                  }
                  return const LoadWidget();
                }),
          ],
        ),
      ),
    );
  }
}
