import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/widgets/app_rating_bar.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/generay_user_info_header.dart';
import 'package:freelancer/common/widgets/icon_with_text_widget.dart';
import 'package:freelancer/common/widgets/layout/outlined_dotted_border_card.dart';
import 'package:freelancer/common/widgets/popup/show_contact_alert_popup.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/model/empler_info.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/flcer_detail_bloc.dart';
import 'package:freelancer/modules/job/bloc/job_detail_state.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/gender.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../common/widgets/error_action_widget.dart';
import '../../common/widgets/load_widget.dart';
import '../../utils/data/load_state_actions.dart';
import 'flcer_detail_bloc/flcer_detail_state.dart';

class FlcerScreen extends StatefulWidget {
  const FlcerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FlcerScreen> createState() => _FlcerScreenState();
}

class _FlcerScreenState extends State<FlcerScreen>
    with SingleTickerProviderStateMixin {
  late final FlcerDetailBloc _flcerDetailBloc = context.read<FlcerDetailBloc>();
  final ScrollController _scrollController = ScrollController();
  double _dy = 0.0;
  double _maxDy = 64.0;
  final ValueNotifier<double> _dyNotif = ValueNotifier<double>(0);

  @override
  void initState() {
    _scrollController.addListener(_listener);
    super.initState();
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
    buildIconWithTextRow({
      required String iconAsset,
      required String field,
      String? data,
      Color? color,
      double size = 30.0,
      double iconSize = 15.0,
      bool showInfo = true,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0 / 2),
        child: Row(
          children: [
            Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: (color?.withOpacity(0.25) ?? AppColors.primaryColor)
                    .withOpacity(0.25),
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                iconAsset,
                fit: BoxFit.cover,
                height: iconSize,
                width: iconSize,
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: RichText(
                textHeightBehavior: const TextHeightBehavior(
                  leadingDistribution: TextLeadingDistribution.even,
                ),
                text: TextSpan(
                  text: field + ': ',
                  style: AppTextStyles.iconWithTextTextStyle,
                  children: [
                    showInfo
                        ? TextSpan(
                            text: data,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              height: 24.59 / 16.0,
                              color: AppColors.textColor,
                            ),
                          )
                        : TextSpan(
                            text: StringConst.usePointToSee,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              height: 23.05 / 15.0,
                              color: AppColors.orangeAccent,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    _buildContainer({
      required Widget child,
    }) =>
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: kPadding(context),
          ),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(kBorderRadius20),
              border: Border.all(
                color: const Color(0xFFDBDBDB),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2.0),
                  blurRadius: 8.0,
                  color: AppColors.appShadowColor,
                ),
              ],
            ),
            child: child,
          ),
        );
    var scrSize = MediaQuery.of(context).size;
    var topPadding = (scrSize.height * 0.4).clamp(0.0, 155.0) + kToolbarHeight;
    return Scaffold(
        appBar: AppAppBar(
          title: Text(StringConst.freelancerDetail.toTitleCase()),
          centerTitle: true,
          elevation: kElevation,
        ),
        backgroundColor: AppColors.lightIrisBlue,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(top: kScaffoldBodyVerticalPadding),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocConsumer(
                bloc: _flcerDetailBloc,
                listener: (_, state) {
                  if (state is JobDetailErrorState &&
                      state.action == ErrorStateActions.alert) {
                    showToast(state.error);
                  }
                },
                buildWhen: (_, state) =>
                    state is FlcerDetailDoneState ||
                    state is FlcerDetailErrorState &&
                        state.action == ErrorStateActions.rebuild ||
                    state is FlcerDetailLoadState &&
                        state.action == LoadStateActions.rebuild,
                builder: (context, state) {
                  if (state is FlcerDetailDoneState) {
                    var flcer = state.info;
                    // List<Proficency> listImg = flcer.proficiency.cast<Proficency>();
                    var location = IconWithTextWidget(
                      iconAsset: AppAsset.icCircleMouseClicker,
                      text: flcer.cityName,
                      textStyle: buildIconWithTextTextStyle(),
                    );
                    var joinDate = IconWithTextWidget(
                      iconAsset: AppAsset.icClock,
                      text: '${StringConst.join}: ${flcer.createdAt.format()}',
                      textStyle: buildIconWithTextTextStyle(),
                    );
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: const Offset(0, 50.0),
                            child: Image.asset(
                              AppAsset.imgFlcerBackground,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          GeneralUserInfoHeader(
                            avatar: flcer.avtSrc,
                            name: flcer.name,
                            children: [
                              location,
                              joinDate,
                            ],
                          ),
                          const SizedBox(height: 10.0 / 2),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0 / 2,
                              horizontal: kPadding(context),
                            ),
                            child: OutlinedDottedBorderCard(
                              elevation: 3.0,
                              shadowColor: AppColors.darkGray.withOpacity(0.4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 15.0 / 2,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  buildIconWithTextRow(
                                    iconAsset: AppAsset.icCalendarRange,
                                    field: StringConst.dob + ': ',
                                    data: flcer.createdAt.format(),
                                  ),
                                  buildIconWithTextRow(
                                    iconAsset: AppAsset.icGender,
                                    field: StringConst.gender,
                                    data: Gender.female.toString(),
                                    color: AppColors.orangeAccent,
                                  ),
                                  buildIconWithTextRow(
                                    iconAsset: AppAsset.icPhone,
                                    field: StringConst.phone,
                                    showInfo: false,
                                  ),
                                  buildIconWithTextRow(
                                    iconAsset: AppAsset.icMailWithoutHeader,
                                    field: StringConst.mail,
                                    showInfo: false,
                                    color: AppColors.orangeAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: kPadding(context),
                            ),
                            child: OutlinedDottedBorderCard(
                              elevation: 3.0,
                              shadowColor: AppColors.darkGray.withOpacity(0.4),
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kBorderRadius),
                                        color: AppColors.orangeAccent,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                        horizontal: 22.0,
                                      ),
                                      child: Text(
                                        flcer.vote.avg ?? "0",
                                        textHeightBehavior:
                                            const TextHeightBehavior(
                                          leadingDistribution:
                                              TextLeadingDistribution.even,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                          height: 30.74 / 20.0,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Xuất sắc',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        height: 27.66 / 18.0,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    CustomRatingBar(
                                        rating: double.parse(
                                            flcer.vote.percent.toString())),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: SizedBox(
                                        height: 125,
                                        width: 125,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            CircularProgressIndicator(
                                              backgroundColor: AppColors
                                                  .primaryColor
                                                  .withOpacity(0.15),
                                              value: 0.75,
                                              strokeWidth: 12.0,
                                              color: AppColors.primaryColor,
                                            ),
                                            const Center(
                                              child: Text(
                                                '75%',
                                                style: TextStyle(
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.w700,
                                                  height: 39.96 / 26.0,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Hoàn thành công việc',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        height: 27.66 / 18.0,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _buildContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildHeaderRow(
                                    text: StringConst.introYourself),
                                const SizedBox(height: 5.0),
                                RichText(
                                  textHeightBehavior: const TextHeightBehavior(
                                    leadingDistribution:
                                        TextLeadingDistribution.proportional,
                                  ),
                                  text: TextSpan(
                                    text: StringConst.expWorking + ': ',
                                    style: AppTextStyles.normalTextStyle(),
                                    children: [
                                      TextSpan(
                                        text: flcer.skillYear,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          height: 24.59 / 16.0,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  flcer.userJob ?? "",
                                  style: AppTextStyles.normalTextStyle(
                                    height: 31.71,
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Text(
                                      StringConst.seeMore,
                                      textHeightBehavior:
                                          AppConst.textHeightBehavior,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        height: 21.03 / 14.0,
                                        color: AppColors.orangeAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildContainer(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildHeaderRow(text: StringConst.skill),
                                const SizedBox(height: 8.0),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  runSpacing: 5.0,
                                  children: flcer.listSkill
                                      .map(
                                        (e) => Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0 / 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(
                                                kBorderRadius10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0,
                                            vertical: 3.0,
                                          ),
                                          child: Text(
                                            e.toString(),
                                            style:
                                                AppTextStyles.normalTextStyle(
                                              height: 21.82,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          _buildContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeaderRow(
                                  text: StringConst.capacityProfile,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.0,
                                      mainAxisSpacing: 20.0,
                                      childAspectRatio: 146.0 / 102.0,
                                    ),
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    itemBuilder: (_, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            kBorderRadius20),
                                        child: SizedBox(
                                          height: 102.0,
                                          width: 146.0,
                                          child: CachedNetworkImage(
                                            imageUrl: //listImg[index],
                                                'https://image.shutterstock.com/image-photo/young-business-man-working-home-260nw-1654831870.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  flcer.userJob ?? " ",
                                  textHeightBehavior:
                                      AppConst.textHeightBehavior,
                                  style: AppTextStyles.normalTextStyle(
                                    height: 31.71,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Thiet_ke_trien_khai_noi_that_2D.pdf',
                                    textHeightBehavior:
                                        AppConst.textHeightBehavior,
                                    style: AppTextStyles.normalTextStyle(
                                      height: 31.71,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Center(
                                  child: AppElevatedButton(
                                    label: StringConst.download,
                                    elevation: 0.0,
                                    onPressed: () {},
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7.0,
                                      horizontal: 22.0,
                                    ),
                                    labelTextStyle: _buildPageButtonTextStyle(
                                      height: 20.11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Container(
                            height: 64.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: kPadding(context)),
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 40.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AppElevatedButton(
                                    onPressed: () {},
                                    elevation: 0.0,
                                    label: StringConst.chat,
                                    primary: AppColors.orangeAccent,
                                    width: 150.0,
                                    labelTextStyle: _buildPageButtonTextStyle(
                                      height: 24.0,
                                    ),
                                  ),
                                  AppElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => ShowContactAlertPopup(),
                                      );
                                    },
                                    elevation: 0.0,
                                    label: StringConst.seeContact,
                                    width: 150.0,
                                    labelTextStyle: _buildPageButtonTextStyle(
                                      height: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is JobDetailErrorState) {
                    return ErrorActionWidget(
                      error: state.error,
                      onPressed: () => _flcerDetailBloc.loadFlcerDetail(),
                    );
                  }
                  return const LoadWidget();
                },
              )
            ],
          ),
        ));
  }

  TextStyle _buildPageButtonTextStyle({double? height}) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      height: (height ?? 20.11) / 16.0,
      color: AppColors.white,
    );
  }

  Row _buildHeaderRow({
    required String text,
  }) {
    return Row(
      children: [
        Text(
          text,
          textHeightBehavior: AppConst.textHeightBehavior,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            height: 27.66 / 18.0,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          width: 24.0,
          height: 3.0,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  buildIconWithTextTextStyle({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return AppTextStyles.iconWithTextTextStyle.copyWith(
      fontSize: 16.0,
      fontWeight: fontWeight ?? FontWeight.w400,
      height: 21.82 / 16.0,
      color: color,
    );
  }
}
