import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/widgets/app_network_image.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/favorite_button.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/list_chip.dart';
import 'package:freelancer/common/widgets/popup/set_price_popup.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/empler/bloc/empler_detail_bloc.dart';
import 'package:freelancer/modules/flcer_order_job/bloc/flcer_order_job_bloc.dart';
import 'package:freelancer/modules/job/bloc/job_detail_bloc.dart';
import 'package:freelancer/modules/profile/bloc/saved_ongoing_project_bloc/saved_project_bloc/saved_project_repo.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/job_type.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/text_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';
import 'package:intl/intl.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.emplerName,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.skillNames,
    required this.skillIds,
    required this.favorite,
    required this.expDate,
    required this.jobId,
    required this.emplerId,
    required this.jobType,
    this.detail = false,
    this.jobCate,
    this.orders,
    this.jobDes,
    this.emplerLogo,
    this.isOrdered,
  }) : super(key: key);

  final JobType jobType;
  final bool detail;
  final String jobId;
  final String jobTitle;
  final String location;
  final String salary;
  final List<String> skillNames;
  final List<int> skillIds;
  final bool favorite;
  final DateTime expDate;
  final String emplerId;
  final String? emplerLogo;
  final String? emplerName;
  final String? jobCate;
  final String? orders;
  final String? jobDes;
  final String? isOrdered;

  @override
  Widget build(BuildContext context) {
    var imgSize = 100.0;
    final _favorKeyState = GlobalKey<FavoriteButtonState>();

    Widget emplerNameText = Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Material(
        color: AppColors.white,
        child: InkWell(
          onTap: () {
            if (CurrentUser.of(context).userType == UserType.freelancer) {
              AppRouter.toPage(
                context,
                AppPages.emplerDetail,
                blocValue: EmplerDetailBloc(id: int.parse(emplerId)),
              );
            }
          },
          child: Text(
            emplerName ?? StringConst.nonUpdateError,
            style: AppTextStyles.textStyle.copyWith(
              color: AppColors.primaryColor,
              height: 21.82 / 16,
            ),
          ),
        ),
      ),
    );

    var locationWidget = IconWithTextWidget(
      iconAsset: AppAsset.icLocationFilled,
      text: location,
      padding: const EdgeInsets.only(top: 10),
    );

    var salaryWidget = IconWithTextWidget(
      iconAsset: AppAsset.icMoney,
      text: salary,
      textStyle: AppTextStyles.iconWithTextTextStyle.copyWith(
        color: AppColors.red,
      ),
      padding: const EdgeInsets.only(top: 10),
    );

    const jobNameTextStyle = TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 24.0 / 16.0,
      color: AppColors.textColor,
    );

    var expiredDate = IconWithTextWidget(
      iconAsset: AppAsset.icTimer,
      text: '${StringConst.expired}: ${expDate.format()}',
      mainAxisSize: MainAxisSize.min,
      padding: EdgeInsets.zero,
    );

    var expiredDateTextSize = Text(
      '${StringConst.expired}: ${expDate.format()}',
      style: AppTextStyles.iconWithTextTextStyle,
    ).getSize();

    var rating = Row(
      children: [
        SvgPicture.asset(
          AppAsset.icHeart,
          height: 15.0,
          width: 15.0,
          fit: BoxFit.cover,
          color: AppColors.iconColor,
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Text(
            orders != null
                ? '$orders ${StringConst.numOfSetPriceOrders}'
                : StringConst.error,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: AppTextStyles.iconWithTextTextStyle,
          ),
        ),
      ],
    );

    return Material(
      color: AppColors.none,
      borderRadius: BorderRadius.circular(kBorderRadius10),
      child: InkWell(
        onTap: () {
          var jobDetailBloc = JobDetailBloc(jobId);
          AppRouter.toPage(
            context,
            AppPages.jobDetail,
            blocValue: jobDetailBloc,
          );
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.appShadowColor,
                    blurRadius: 8.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius10),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            AppNetworkImage(
                              // imageUrl: emplerLogo ??
                              //     'https://i.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI',
                              imageUrl: emplerLogo,
                              imgSize: imgSize,
                              errorWidget: Image.asset(
                                AppAsset.imgNonLogoIcon,
                                height: imgSize,
                                width: imgSize,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: imgSize,
                              color: Colors.black.withOpacity(0.6),
                              alignment: Alignment.center,
                              child: Text(
                                jobType.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppConst.fontNunito,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  height: 20.46 / 15.0,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: kSizedBoxWidth),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              jobTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: jobNameTextStyle,
                            ),
                            emplerNameText,
                            detail
                                ? IconWithTextWidget(
                                    iconAsset: AppAsset.icBag,
                                    text: jobCate ?? StringConst.error,
                                    textStyle: jobNameTextStyle.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                    padding: const EdgeInsets.only(top: 10),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      locationWidget,
                                      salaryWidget,
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (detail)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        locationWidget,
                        salaryWidget,
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: expiredDateTextSize.width + 15.0 + 5,
                                child: expiredDate,
                              ),
                              const SizedBox(width: 15.0),
                              Flexible(child: rating),
                            ],
                          ),
                        ),
                        if (jobDes != null && jobDes!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              jobDes!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppConst.fontNunito,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray,
                                height: 19.1 / 14.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        StringConst.skill + ': ',
                        style: AppTextStyles.chipTextStyle
                            .copyWith(fontSize: 15.0),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ListChip(
                          values: skillNames,
                          limit: 2,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.12,
                      vertical: 5.0,
                    ),
                    child: AppElevatedButton(
                      elevation: 0,
                      label: StringConst.setPrice,
                      onPressed: () {
                        var orderBloc = FlcerOrderJobBloc();
                        showDialog(
                          context: context,
                          builder: (_) => Center(
                            child: BlocProvider.value(
                              value: orderBloc,
                              child: SetPricePopup(
                                expDate: DateFormat('yyyy-MM-dd')
                                    .format(expDate)
                                    .toString(),
                                jobId: jobId,
                                jobTitle: jobTitle,
                              ),
                            ),
                          ),
                        );
                      },
                      labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            FavoriteButton(
              key: _favorKeyState,
              onPressed: () async {
                var repo = SavedProjectRepo();
                ResultData res;
                var favoriteButtonState = _favorKeyState.currentState!;
                if (favoriteButtonState.favorite) {
                  res = await repo.deleteSavedProject(jobId: jobId);
                  showToast(res.message.toString());
                } else {
                  res = await repo.saveProject(jobId: jobId);
                  showToast(res.message.toString());
                }
                if (res.result) {
                  // showToast(res.message);
                } else {
                  favoriteButtonState.updateState();
                  showToast(res.error.toString());
                }
              },
              favorite: favorite,
            ),
          ],
        ),
      ),
    );
  }
}
