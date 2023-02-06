import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/common/widgets/app_rating_bar.dart';
import 'package:freelancer/common/widgets/button/app_drop_down_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/common/widgets/header.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/rating_bar.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_bloc.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../../common/widgets/button/app_elevated_button.dart';
import '../../../router/app_pages.dart';
import '../../../router/app_router.dart';
import '../../flcer/flcer_detail_bloc/flcer_detail_bloc.dart';
import '../bloc/working_flcer_bloc/working_flcer_card_bloc.dart';
import '../bloc/working_flcer_bloc/working_flcer_sate.dart';

class EmplerFlcerWorkingWithPage extends StatefulWidget {
  const EmplerFlcerWorkingWithPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EmplerFlcerWorkingWithPage> createState() =>
      _EmplerFlcerWorkingWithPageState();
}

class _EmplerFlcerWorkingWithPageState
    extends State<EmplerFlcerWorkingWithPage> {
  @override
  Widget build(BuildContext context) {
    List<FlcWorking> workingFlcer = [];
    final workingFlcerBloc = context.read<WorkingFlcerBloc>();
    String voteText;
    // workingFlcerBloc.loadData();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<WorkingFlcerBloc, WorkingFlcerState>(
          bloc: workingFlcerBloc,
          builder: (context, state) {
            workingFlcer = [...state.workingFlcer];
            // child: SingleChildScrollView(
            return RefreshIndicator(
              onRefresh: () => workingFlcerBloc.loadData(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPadding(context),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Header(header: StringConst.listWorkingWithFlcer),
                      const SizedBox(height: 15.0),
                      ...workingFlcer.map(
                        (flcer) {
                          return InkWell(
                            onTap: () {
                              var flcerDetailBloc =
                                  FlcerDetailBloc(flcer.flcId);
                              AppRouter.toPage(context, AppPages.flcerDetail,
                                  blocValue: flcerDetailBloc);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 12.0,
                              ),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              width: double.infinity,
                              // height: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black15,
                                    offset: const Offset(0, 2),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    flcer.freelancerName,
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
                                  Text(
                                    flcer.jobName,
                                    style: AppTextStyles.normalTextStyle(),
                                  ),
                                  const SizedBox(height: 10.0),
                                  IconWithTextWidget(
                                    iconAsset: AppAsset.icCoin,
                                    text: flcer.salary,
                                    iconColor: AppColors.red,
                                    textStyle: const TextStyle(
                                      fontFamily: AppConst.fontNunito,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 24 / 15.0,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  IconWithTextWidget(
                                    iconAsset: AppAsset.icTimer,
                                    text: StringConst.expired +
                                        ': ' +
                                        flcer.dateBidEnd.format(),
                                  ),
                                  // Random().nextBool()
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RichText(
                                        textHeightBehavior:
                                            AppConst.textHeightBehavior,
                                        text: TextSpan(
                                          text: StringConst.rating + ': ',
                                          style: const TextStyle(
                                            fontFamily: AppConst.fontNunito,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            height: 22 / 16.0,
                                            color: AppColors.textColor,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: flcer.star ??
                                                  "0" +
                                                      '/' +
                                                      kMaxRating.toString(),
                                              style: const TextStyle(
                                                fontFamily: AppConst.fontNunito,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                height: 21.82 / 16.0,
                                                color: AppColors.orangeAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Expanded(
                                        child: RatingBar(
                                          rating:
                                              double.parse(flcer.star ?? '0.0'),
                                          unRatingColor: AppColors.orangeAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppOutlinedButton(
                                    child: StringConst.rating,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          var scrSize =
                                              MediaQuery.of(context).size;
                                          return RateJobDialog(
                                            scrSize: scrSize,
                                            job: flcer.jobName,
                                          );
                                        },
                                      );
                                    },
                                    width: double.infinity,
                                    borderColor: AppColors.orangeAccent,
                                    labelTextStyle: const TextStyle(
                                      fontFamily: AppConst.fontNunito,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      height: 24 / 16.0,
                                      color: AppColors.orangeAccent,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  // check,
                                  AppDropDownButton(
                                    width: double.infinity,
                                    radius: kBorderRadius10,
                                    itemHeight: 40.0,
                                    choices: const [
                                      'Hoan thanh',
                                      'Khong hoan thanh',
                                      'Dang thuc hien',
                                    ],
                                    itemTextStyles: [
                                      _buildStatusTextStyle(
                                          color: AppColors.primaryColor),
                                      _buildStatusTextStyle(
                                          color: AppColors.red),
                                      _buildStatusTextStyle(
                                        color: AppColors.orangeAccent,
                                      ),
                                    ],
                                    // initChoice: int.parse(flcer.statusWork),
                                    onTap: (value) {
                                      voteText = value.toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  TextStyle _buildStatusTextStyle({
    Color? color,
  }) {
    return TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 24 / 16.0,
      color: color ?? AppColors.textColor,
    );
  }
}

class RateJobDialog extends StatefulWidget {
  const RateJobDialog({
    Key? key,
    required this.scrSize,
    required this.job,
  }) : super(key: key);

  final Size scrSize;
  final String job;

  @override
  State<RateJobDialog> createState() => _RateJobDialogState();
}

class _RateJobDialogState extends State<RateJobDialog> {
  late double _rating;
  var rateText = [
    'Kém',
    'Trung bình',
    'Khá',
    'Tốt',
    'Xuất sắc',
  ];

  @override
  void initState() {
    _rating = 4.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: StringConst.rateJob,
      centerTitle: false,
      isShowCancelButton: true,
      padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 30.0),
      content: Column(
        children: [
          const SizedBox(height: 20.0),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(kBorderRadius10),
                child: SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.shutterstock.com/image-photo/young-business-man-working-home-260nw-1654831870.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.job,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 24 / 16.0,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Hoan thanh',
                      style: AppTextStyles.normalTextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Center(
            child: CustomRatingBar(
              rating: _rating,
              widthSep: 5.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.spaceAround,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10.0,
            children: List.generate(
              kMaxRating,
              (index) => AppOutlinedButton(
                child: rateText[index],
                borderRadius: BorderRadius.circular(kBorderRadius10),
                labelTextStyle: const TextStyle(
                  fontFamily: AppConst.fontNunito,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 24 / 16.0,
                  color: AppColors.primaryColor,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 14.5,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index.toDouble() + 1;
                  });
                },
              ),
            ).toList(),
          ),
          const SizedBox(height: 20.0),
          CoupleBottomOutlinedAndElevatedButtons(
            firstLabel: StringConst.cancel,
            secondaryLabel: StringConst.rating,
            padding: EdgeInsets.zero,
            onPressedFirstButton: () {},
            height: 40.0,
            buttonLabelPadding: const EdgeInsets.symmetric(vertical: 8),
          )
        ],
      ),
    );
  }
}
