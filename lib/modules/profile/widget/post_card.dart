import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/home/empler/bloc/refresh_job_bloc/refresh_job_repo.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/get_posted_job.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../router/app_pages.dart';
import '../../../router/app_router.dart';
import '../../job/bloc/job_detail_bloc.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.job,
    this.margin,
  }) : super(key: key);

  final PostedJob job;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      context,
      c,
    ) {
      return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: kPadding(context), vertical: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              // margin: margin,
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 12.0,
              ),
              width: c.maxWidth - 2 * kPadding(context),
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
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: job.titleJob,
                      style: const TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 24 / 16.0,
                        color: AppColors.textColor,
                      ),
                      children: [
                        TextSpan(
                          text: StringConst.seeDetail,
                          style: const TextStyle(
                            fontFamily: AppConst.fontNunito,
                            fontSize: 16,
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
                  const SizedBox(height: 10.0),
                  IconWithTextWidget(
                    iconAsset: AppAsset.icCircleWork,
                    text: job.jobType == '0' ? "Theo dự án" : " Bán thời gian",
                    textStyle: const TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 24 / 14.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  IconWithTextWidget(
                    iconAsset: AppAsset.icTimer,
                    text: StringConst.expired + ': ' + job.date,
                    // (job.expiredDate.isAfter(DateTime.now())
                    //     ? StringConst.expired
                    //     : job.expiredDate.format()),
                    textStyle: const TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 19.1 / 14.0,
                      color: AppColors.textColor,
                    ),
                  ),
                  const IconWithTextWidget(
                    iconAsset: AppAsset.icCircleCorrect,
                    text: "Đã đăng",
                    textStyle: TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 24 / 14.0,
                      color: AppColors.green,
                    ),
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
                    onPressed: () async {
                      var _repo = RefreshJobRepo();
                      var res =
                          await _repo.refreshJob(jobId: int.parse(job.id));
                      if (res.result) {
                        showToast(res.message.toString());
                      } else {
                        showToast(res.error.toString());
                      }
                    },
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
          ]));
    });
  }
}
