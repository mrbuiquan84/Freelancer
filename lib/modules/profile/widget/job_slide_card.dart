import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/post_empler_general.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/get_posted_job.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../router/app_pages.dart';
import '../../../router/app_router.dart';
import '../../job/bloc/job_detail_bloc.dart';

class JobSlideCard extends StatelessWidget {
  const JobSlideCard({
    Key? key,
    required this.job,
    this.margin,
  }) : super(key: key);
  final Data2 job;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        c,
      ) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: kPadding(context), vertical: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 12.0,
                ),
                width: c.maxWidth - 2 * kPadding(context),
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
                  children: [
                    RichText(
                      text: TextSpan(
                        text: job.titleJob + ' ',
                        style: const TextStyle(
                          fontFamily: AppConst.fontNunito,
                          fontSize: 16.0,
                          height: 24.0 / 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                        children: [
                          TextSpan(
                            text: StringConst.seeDetail,
                            style: const TextStyle(
                              fontFamily: AppConst.fontNunito,
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              height: 24 / 16.0,
                              color: AppColors.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                var jobDetailBloc = JobDetailBloc(job.id);
                                AppRouter.toPage(
                                  context,
                                  AppPages.jobDetail,
                                  blocValue: jobDetailBloc,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    IconWithTextWidget(
                      iconAsset: AppAsset.icMoney,
                      text: job.salaryPermanentNumber,
                      padding: const EdgeInsets.only(top: 10.0),
                      textStyle: const TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 19 / 14.0,
                        color: AppColors.red,
                      ),
                    ),
                    IconWithTextWidget(
                      iconAsset: AppAsset.icTimer,
                      text: StringConst.expired + ': ' + job.date,
                      padding: const EdgeInsets.only(top: 10.0),
                    ),
                    IconWithTextWidget(
                      iconAsset: AppAsset.icHeart,
                      text: job.freelancerBided.toString() +
                          ' ' +
                          StringConst.setPriceTimes,
                      padding: const EdgeInsets.only(top: 10.0),
                      iconColor: AppColors.orangeAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(width: kPadding(context)),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppAsset.icRefresh,
                      ),
                      label: Text(
                        StringConst.refresh,
                        style: AppTextStyles.buttonNormalTxtStyle.copyWith(
                          height: 24.59 / 16.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        elevation: kElevation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius10),
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 5.5),
                      ),
                    ),
                    // const SizedBox(height: 10.0),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppAsset.icPencilEdit,
                      ),
                      label: Text(
                        StringConst.edit,
                        style: AppTextStyles.buttonNormalTxtStyle.copyWith(
                          height: 24.59 / 16.0,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        elevation: kElevation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kBorderRadius10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
