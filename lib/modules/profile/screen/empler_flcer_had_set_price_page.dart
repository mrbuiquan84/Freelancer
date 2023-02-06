import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/header.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/had_set_price_bloc/had_set_price_bloc.dart';
import 'package:freelancer/modules/profile/had_set_price_bloc/had_set_price_state.dart';
import 'package:freelancer/modules/profile/widget/flcer_had_set_price_card.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../common/services/http/result_data.dart';
import '../../../common/widgets/button/app_elevated_button.dart';
import '../../../common/widgets/button/app_outlined_button.dart';
import '../../../common/widgets/icon_with_text_widget.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/asset_path.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../router/app_pages.dart';
import '../../../router/app_router.dart';
import '../../../utils/ui/show_toast.dart';
import '../../flcer/flcer_detail_bloc/flcer_detail_bloc.dart';
import '../bloc/confirm_set_price_bloc/confirm_set_price_repo.dart';

class EmplerFlcerHadSetPricePage extends StatefulWidget {
  const EmplerFlcerHadSetPricePage({
    Key? key,
  }) : super(key: key);

  @override
  State<EmplerFlcerHadSetPricePage> createState() =>
      _EmplerFlcerHadSetPricePageState();
}

class _EmplerFlcerHadSetPricePageState
    extends State<EmplerFlcerHadSetPricePage> {
  @override
  Widget build(BuildContext context) {
    List<FlcPrice> flcerPrice = [];
    final hadSetPriceBloc = context.read<HadSetPriceBloc>();
    Widget FlcerHadSetPriceCard(FlcPrice flcer) {
      return InkWell(
        onTap: () {
          var flcerDetailBloc = FlcerDetailBloc(flcer.flcId);
          AppRouter.toPage(context, AppPages.flcerDetail,
              blocValue: flcerDetailBloc);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
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
                text: flcer.salaryExpected.salaryPermanentNumber + " VNĐ",
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
                text: StringConst.phone + ': ' + flcer.freelancerPhone,
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
                        var repo = ConfirmSetPriceRepo();
                        ResultData res = await repo.confirmSetPriceRepo(
                            isconfirm: 2,
                            jobId: int.parse(flcer.jobId),
                            flcID: int.parse(flcer.flcId));
                        if (res.result) {
                          showToast(res.message.toString());
                        } else {
                          showToast(res.error.toString());
                        }
                        setState(() {
                          hadSetPriceBloc.loadData();
                        });
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
                        var repo = ConfirmSetPriceRepo();
                        ResultData res = await repo.confirmSetPriceRepo(
                            isconfirm: 1,
                            jobId: int.parse(flcer.jobId),
                            flcID: int.parse(flcer.flcId));
                        if (res.result) {
                          showToast(res.message.toString());
                        } else {
                          showToast(res.error.toString());
                        }
                        setState(() {
                          hadSetPriceBloc.loadData();
                        });
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

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<HadSetPriceBloc, HadSetPriceState>(
          bloc: hadSetPriceBloc,
          builder: (context, state) {
            flcerPrice = [...state.flcerPrice];
            return RefreshIndicator(
              onRefresh: () => hadSetPriceBloc.loadData(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPadding(context),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Header(
                        header: StringConst.listHadSetPriceFlcer,
                      ),
                      const SizedBox(height: 5.0),
                      ...flcerPrice
                          .map(
                            (e) => FlcerHadSetPriceCard(e),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
