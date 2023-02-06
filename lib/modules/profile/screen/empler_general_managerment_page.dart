import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/header.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/job/bloc/job_detail_bloc.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/empler_general_bloc.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/empler_general_state.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/post_empler_general.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/get_posted_job.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_bloc.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_state.dart';
import 'package:freelancer/modules/profile/widget/flcer_had_set_price_card.dart';
import 'package:freelancer/modules/profile/widget/job_slide_card.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../../common/services/http/result_data.dart';
import '../../../common/widgets/button/app_elevated_button.dart';
import '../../../common/widgets/button/app_outlined_button.dart';
import '../../../common/widgets/error_action_widget.dart';
import '../../../common/widgets/icon_with_text_widget.dart';
import '../../../common/widgets/load_widget.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../utils/data/load_state_actions.dart';
import '../../flcer/flcer_detail_bloc/flcer_detail_bloc.dart';
import '../bloc/confirm_set_price_bloc/confirm_set_price_repo.dart';

class EmplerGeneralManagermentPage extends StatefulWidget {
  const EmplerGeneralManagermentPage({Key? key}) : super(key: key);

  @override
  State<EmplerGeneralManagermentPage> createState() =>
      _EmplerGeneralManagermentPageState();
}

class _EmplerGeneralManagermentPageState
    extends State<EmplerGeneralManagermentPage> {
  late final emplerGeneralBloc = context.read<EmplerGeneralBloc>();
  @override
  Widget build(BuildContext context) {
    var _statisticFields = [
      StringConst.setPriceFlcer,
      StringConst.savedFlcer,
      StringConst.doneJob,
      StringConst.ongoingFlcer,
    ];

    var _statisticIcons = [
      AppAsset.icMoneyBag,
      AppAsset.icUser,
      AppAsset.icSuitcaseOutlined,
      AppAsset.icWorking,
    ];

    var scrSize = MediaQuery.of(context).size;
    List<Data3> listFlcer;
    List<Data2> listJob;
    Data1 general;
    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.generalManagement.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: SingleChildScrollView(
        child: BlocConsumer<EmplerGeneralBloc, EmplerGeneralState>(
          bloc: emplerGeneralBloc,
          listener: (_, state) {
            if (state is EmplerGeneralLoadState &&
                state.action == ErrorStateActions.alert) {
              showToast(state.action.toString());
            }
          },
          buildWhen: (_, state) {
            var c1 = state.runtimeType == EmplerGeneralState;
            var c2 = (state is EmplerGeneralErrorState &&
                state.action == ErrorStateActions.rebuild);
            var c3 = (state is EmplerGeneralLoadState &&
                state.action == LoadStateActions.rebuild);
            var c4 = (state is EmplerGeneralDoneState);
            var rebuildCondition = c1 || c2 || c3 || c4;
            return rebuildCondition;
          },
          builder: (_, state) {
            if (state is EmplerGeneralErrorState) {
              return ErrorActionWidget(
                error: state.error.toString(),
                onPressed: emplerGeneralBloc.getData(),
              );
            }
            // } else if (state is EmplerGeneralLoadState) {
            //   return const LoadWidget();
            // }
            if (state is EmplerGeneralDoneState) {
              listFlcer = state.flcers;
              listJob = state.jobs;
              general = state.general;
              List<int> _number = [
                listFlcer.length,
                general.freelancerSaved,
                general.freelancerFinish,
                general.freelancerDoing,
              ];
              return Container(
                color: AppColors.white,
                margin:
                    const EdgeInsets.only(top: kScaffoldBodyVerticalPadding),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kPadding(context)),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.8,
                          crossAxisSpacing: 25.0 / 375.0 * scrSize.width,
                          mainAxisSpacing: 20.0 / 375.0 * scrSize.width,
                        ),
                        itemCount: _statisticFields.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        itemBuilder: (_, index) {
                          return _StatisticButton(
                            header: _statisticIcons[index],
                            number: _number[index],
                            data: _statisticFields[index],
                            color: !index.isOdd
                                ? const Color(0xFF08827C)
                                : AppColors.orangeAccent,
                            backgroundColor: !index.isOdd
                                ? AppColors.lightIrisBlue
                                : const Color(0xFFFFF6E5),
                            onPressed: () {},
                          );
                        },
                      ),
                    ),
                    Header(
                      header: StringConst.listNewestJob,
                      padding:
                          EdgeInsets.symmetric(horizontal: kPadding(context)),
                    ),
                    ...listJob
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: JobSlideCard(
                              job: e,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 4.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 5.0),
                    Header(
                      header: StringConst.listNewestFlcer,
                      padding:
                          EdgeInsets.symmetric(horizontal: kPadding(context)),
                    ),
                    const SizedBox(height: 5.0),
                    ...listFlcer
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: kPadding(context),
                            ),
                            child: FlcerHadSetPriceCard2(context, e),
                          ),
                        )
                        .toList(),
                  ],
                ),
              );
            }
            return const LoadWidget();
          },
        ),
      ),
    );
  }
}

class _StatisticButton extends StatelessWidget {
  const _StatisticButton({
    Key? key,
    required this.header,
    required this.color,
    required this.backgroundColor,
    required this.number,
    required this.data,
    this.onPressed,
  }) : super(key: key);

  final String header;
  final Color color;
  final Color backgroundColor;
  final int number;
  final String data;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double _outterRadius = 20.0;
    double _thickness = 4.0;
    double _iconPadding = 4.0;
    double _iconSize = (_outterRadius - _thickness - _iconPadding) * 2;

    return Padding(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(kBorderRadius10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 0),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    number.toString(),
                    style: TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      height: 24.0 / 16.0,
                      color: color,
                    ),
                  ),
                  Text(
                    data,
                    style: const TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      height: 24.0 / 13.0,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            // top: -8.0,
            // left: -4.0,
            offset: const Offset(-4.0, -8.0),
            child: CircleAvatar(
              radius: _outterRadius,
              backgroundColor: backgroundColor,
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: _outterRadius - _thickness,
                child: SvgPicture.asset(
                  header,
                  height: _iconSize,
                  width: _iconSize,
                  fit: BoxFit.cover,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget FlcerHadSetPriceCard2(BuildContext context, Data3 flcer) {
  return InkWell(
    onTap: () {
      var flcerDetailBloc = FlcerDetailBloc(flcer.flcId);
      AppRouter.toPage(context, AppPages.flcerDetail,
          blocValue: flcerDetailBloc);
    },
    child: Container(
      // margin: widget.margin,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 4.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(kBorderRadius20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black15,
            offset: const Offset(0, 2),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            flcer.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              height: 24 / 18.0,
              color: AppColors.orangeAccent,
              fontFamily: AppConst.fontNunito,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Material(
              color: AppColors.white,
              child: InkWell(
                onTap: () {
                  // AppRouter.toPage(
                  //                 context,
                  //                 AppPages.jobDetail,
                  //                 blocValue: JobDetailBloc(jobId),
                  //               );
                },
                child: Text(
                  flcer.titleJob,
                  style: AppTextStyles.textStyle.copyWith(
                    color: AppColors.primaryColor,
                    height: 21.82 / 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          IconWithTextWidget(
            iconAsset: AppAsset.icCoin,
            text: flcer.salaryPermanentNumber + " VNĐ",
            iconColor: AppColors.red,
            textStyle: const TextStyle(
              fontFamily: AppConst.fontNunito,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 24 / 15.0,
              color: AppColors.red,
            ),
          ),
          RichText(
            text: TextSpan(
              text: StringConst.setPriceRange + ': ',
              style: const TextStyle(
                fontFamily: AppConst.fontNunito,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 24 / 15.0,
                color: AppColors.gray,
              ),
              children: [
                TextSpan(
                  // TODO: muc gia freelancer dat
                  text: flcer.salary,
                  style: const TextStyle(
                    fontFamily: AppConst.fontNunito,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 24 / 15.0,
                    color: AppColors.red,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          IconWithTextWidget(
            iconAsset: AppAsset.icCirclePhoneCalling,
            iconSize: 22.0,
            text: StringConst.phone + ': ' + flcer.phone,
            textStyle: const TextStyle(
              fontFamily: AppConst.fontNunito,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 24 / 15.0,
              color: AppColors.textColor,
            ),
            padding: const EdgeInsets.only(bottom: 20.0),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: AppOutlinedButton(
          //         elevation: 0.0,
          //         child: StringConst.refuse,
          //         buttonPrimaryColor: AppColors.red,
          //         onPressed: () async {
          //           var repo = ConfirmSetPriceRepo();
          //           ResultData res = await repo.confirmSetPriceRepo(
          //               isconfirm: 2,
          //               jobId: int.parse(flcer.jobId),
          //               flcID: int.parse(flcer.flcId));
          //           if (res.result) {
          //             showToast(res.message.toString());
          //           } else {
          //             showToast(res.error.toString());
          //           }
          //         },
          //         width: double.infinity,
          //         labelTextStyle: const TextStyle(
          //           fontFamily: AppConst.fontNunito,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w700,
          //           height: 24 / 16.0,
          //           color: AppColors.red,
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: kPadding(context)),
          //     Expanded(
          //       flex: 1,
          //       child: AppElevatedButton(
          //         elevation: 0.0,
          //         label: StringConst.accept,
          //         onPressed: () async {
          //           var repo = ConfirmSetPriceRepo();
          //           ResultData res = await repo.confirmSetPriceRepo(
          //               isconfirm: 1,
          //               jobId: int.parse(flcer.jobId),
          //               flcID: int.parse(flcer.flcId));
          //           if (res.result) {
          //             showToast(res.message.toString());
          //           } else {
          //             showToast(res.error.toString());
          //           }
          //         },
          //         width: double.infinity,
          //         labelTextStyle: const TextStyle(
          //           fontFamily: AppConst.fontNunito,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w700,
          //           height: 24 / 16.0,
          //           color: AppColors.white,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ),
  );
}
