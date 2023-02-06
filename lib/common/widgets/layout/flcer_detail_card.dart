import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/services/http/result_data.dart';

import 'package:freelancer/common/widgets/app_chip.dart';
import 'package:freelancer/common/widgets/app_network_image.dart';
import 'package:freelancer/common/widgets/button/favorite_button.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/rating_bar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/flcer_detail_bloc.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/post_flcer_detail_result.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_repo.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../../core/constants/app_constants.dart';
import '../app_circle_avatar.dart';

class FlcerDetailCard extends StatelessWidget {
  const FlcerDetailCard({
    Key? key,
    required this.name,
    required this.job,
    required this.id,
    required this.location,
    required this.skills,
    required this.rating,
    required this.favoriteButton,
    this.avatar,
    // this.isShowFavoriteButton = true,
  }) : super(key: key);

  // final bool isShowFavoriteButton;
  final String id;
  final String name;
  final String? job;
  final String location;
  final List<String> skills;
  final double rating;
  final bool favoriteButton;
  final String? avatar;
  @override
  Widget build(BuildContext context) {
    var imgSize = 100.0;
    final _favorKeyState = GlobalKey<FavoriteButtonState>();
    const nameTextStyle = TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 24.0 / 16.0,
      color: AppColors.textColor,
    );
    var jobText = Text(
      job ?? StringConst.nonUpdateError,
      style: AppTextStyles.textStyle.copyWith(
        color: AppColors.primaryColor,
        height: 21.82 / 16,
      ),
    );
    var ratingwidget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 5.0),
        Expanded(
          child: RatingBar(
            rating: rating,
            unRatingColor: AppColors.orangeAccent,
          ),
        ),
      ],
    );

    return Material(
        color: AppColors.none,
        borderRadius: BorderRadius.circular(kBorderRadius10),
        child: InkWell(
            onTap: () {
              var flcerDetailBloc = FlcerDetailBloc(id);
              AppRouter.toPage(context, AppPages.flcerDetail,
                  blocValue: flcerDetailBloc);
            },
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(kBorderRadius20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appShadowColor,
                      blurRadius: 8.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCircleAvatar(
                        nonAvatarAsset: AppAsset.imgNonLogoIcon,
                        imgSize: 100.0,
                        avatar: avatar,
                      ),
                      const SizedBox(
                        width: kSizedBoxWidth,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textHeightBehavior: const TextHeightBehavior(
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              height: 24.0 / 16.0,
                              color: AppColors.textColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              job ?? "Chưa cập nhật ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                height: 21.82 / 16.0,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          IconWithTextWidget(
                            iconAsset: AppAsset.icLocationFilled,
                            text: location,
                          ),
                          ratingwidget
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    runSpacing: 10.0,
                    children: [
                      const Text(
                        StringConst.skill + ': ',
                        textHeightBehavior: TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          height: 20.46 / 15.0,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      ...skills
                          .map(
                            (e) => AppChip(
                              label: e,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              // padding: const EdgeInsets.only(right: 10.0),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ]),
              ),
              FavoriteButton(
                key: _favorKeyState,
                favorite: favoriteButton,
                // favorite: favoriteButton,
                onPressed: () async {
                  var repo = SaveFlcerCardRepo();
                  ResultData res;
                  var favoriteButtonState = _favorKeyState.currentState!;
                  if (favoriteButtonState.favorite) {
                    res = await repo.saveFlcer(flcerId: id);
                  } else {
                    res = await repo.saveFlcer(flcerId: id);
                  }
                  if (res.result) {
                    showToast(res.message.toString());
                  } else {
                    favoriteButtonState.updateState();
                    showToast(res.error.toString());
                  }
                },
              )
            ])));
  }
}
