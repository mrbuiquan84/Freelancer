import 'package:flutter/material.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/bloc/confirm_set_price_bloc/confirm_set_price_repo.dart';
import 'package:freelancer/modules/profile/screen/empler_flcer_had_set_price_page.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../router/app_pages.dart';
import '../../../router/app_router.dart';
import '../../../utils/ui/show_toast.dart';
import '../../flcer/flcer_detail_bloc/flcer_detail_bloc.dart';

class FlcerHadSetPriceCard extends StatefulWidget {
  const FlcerHadSetPriceCard({
    Key? key,
    required this.flcer,
    // required this.flcers,
    this.margin,
  }) : super(key: key);

  final FlcPrice flcer;
  final EdgeInsetsGeometry? margin;

  @override
  State<FlcerHadSetPriceCard> createState() => _FlcerHadSetPriceCardState();
}

class _FlcerHadSetPriceCardState extends State<FlcerHadSetPriceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var flcerDetailBloc = FlcerDetailBloc(widget.flcer.flcId);
        AppRouter.toPage(context, AppPages.flcerDetail,
            blocValue: flcerDetailBloc);
      },
      child: Container(
        margin: widget.margin,
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 12.0,
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
              widget.flcer.freelancerName,
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
              widget.flcer.jobName,
              style: AppTextStyles.normalTextStyle(),
            ),
            const SizedBox(height: 10.0),
            IconWithTextWidget(
              iconAsset: AppAsset.icCoin,
              text: widget.flcer.salaryExpected.salaryPermanentNumber + " VNĐ",
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
                    text: widget.flcer.salary,
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
              text: StringConst.phone + ': ' + widget.flcer.freelancerPhone,
              textStyle: const TextStyle(
                fontFamily: AppConst.fontNunito,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 24 / 15.0,
                color: AppColors.textColor,
              ),
              padding: const EdgeInsets.only(bottom: 20.0),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppOutlinedButton(
                    elevation: 0.0,
                    child: StringConst.refuse,
                    buttonPrimaryColor: AppColors.red,
                    onPressed: () async {
                      // var repo = ConfirmSetPriceRepo();
                      // ResultData res = await repo.confirmSetPriceRepo(
                      //     isconfirm: 2,
                      //     jobId: int.parse(widget.flcer.jobId),
                      //     flcID: int.parse(widget.flcer.flcId));
                      // if (res.result) {
                      //   showToast(res.message.toString());
                      // } else {
                      //   showToast(res.error.toString());
                      // }
                      setState(() {});
                    },
                    width: double.infinity,
                    labelTextStyle: const TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 24 / 16.0,
                      color: AppColors.red,
                    ),
                  ),
                ),
                SizedBox(width: kPadding(context)),
                Expanded(
                  flex: 1,
                  child: AppElevatedButton(
                    elevation: 0.0,
                    label: StringConst.accept,
                    onPressed: () async {
                      // var repo = ConfirmSetPriceRepo();
                      // ResultData res = await repo.confirmSetPriceRepo(
                      //     isconfirm: 1,
                      //     jobId: int.parse(widget.flcer.jobId),
                      //     flcID: int.parse(widget.flcer.flcId));
                      // if (res.result) {
                      //   showToast(res.message.toString());
                      // } else {
                      //   showToast(res.error.toString());
                      // }
                      // setState(() {
                      //   widget.flcers.remove(widget.flcer);
                      // });
                    },
                    width: double.infinity,
                    labelTextStyle: const TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 24 / 16.0,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
