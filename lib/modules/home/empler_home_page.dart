import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/cate_header_widget.dart';
import 'package:freelancer/common/widgets/dot_line.dart';
import 'package:freelancer/common/widgets/layout/flcer_detail_card.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/empler/bloc/post_job_bloc/post_job_bloc.dart';
import 'package:freelancer/modules/home/empler/empler_home_bloc.dart';
import 'package:freelancer/modules/home/empler/empler_home_state.dart';
import 'package:freelancer/modules/home/empler/get_empler_home_data_result.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_bloc.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../common/widgets/appbar/empler_home_appbar.dart';
import '../../utils/data/city.dart';
import '../../utils/data/error_state_action.dart';
import '../../utils/data/load_state_actions.dart';
import '../../utils/data/search_cate_type.dart';
import '../bloc/app_repo.dart';
import '../search/bloc/search_bloc.dart';
import '../search/search_filter_screen.dart';
import '../search/search_screen.dart';

class EmplerHomePage extends StatefulWidget {
  const EmplerHomePage({Key? key}) : super(key: key);

  @override
  State<EmplerHomePage> createState() => _EmplerHomePageState();
}

class _EmplerHomePageState extends State<EmplerHomePage> {
  late final EmplerHomeBloc _homeBloc;
  List<Info> _flcers = [];
  // final _notifButtonKey = GlobalKey();
  late final _fabKey = GlobalKey();
  late final SearchFlcerBloc _searchBloc;
  late final AppRepo _appRepo;

  @override
  void initState() {
    _homeBloc = context.read<EmplerHomeBloc>();
    _appRepo = context.read<AppRepo>();
    _searchBloc = SearchFlcerBloc();
    super.initState();
  }

  // RenderBox _getRenderBox(GlobalKey key) {
  //   return key.currentContext!.findRenderObject() as RenderBox;
  // }
  void _listFlcerScreen() {
    _searchBloc.lastSearch..page = 1;
    _searchBloc.searchFlcer(
      whenError: ErrorStateActions.rebuild,
      whenLoad: LoadStateActions.rebuild,
    );
    AppRouter.toPage(
      context,
      AppPages.listFlcerSceen,
      blocValue: _searchBloc,
    ).then((value) => _searchBloc.reset());
  }

  Widget _buildPopupButton({
    required String label,
    VoidCallback? onPressed,
    Color? color,
  }) {
    return AppElevatedButton(
      label: label,
      primary: color,
      height: 40.0,
      width: 197.0,
      onPressed: onPressed,
      elevation: 0,
      labelTextStyle: const TextStyle(
        fontFamily: AppConst.fontNunito,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 25 / 16.0,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildFAButton({
    VoidCallback? onPressed,
    Key? key,
  }) {
    return FloatingActionButton(
      key: key,
      onPressed: onPressed,
      child: SvgPicture.asset(AppAsset.icAddFilled),
      backgroundColor: AppColors.orangeAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _indicatorIcon = const SizedBox(
      key: ValueKey('circular'),
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryColor,
        strokeWidth: 2.0,
      ),
    );
    Widget _downIcon = const Icon(
      Icons.arrow_downward,
      key: ValueKey('arrow'),
    );
    bool _isLoading = false;
    var _button = SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          // await _homeBloc.loadData();
          await _homeBloc.getFlcers(
            onError: ErrorStateActions.alert,
            onLoad: LoadStateActions.none,
          );
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(0.0, 0.5), end: Offset.zero),
              ),
              child: FadeTransition(
                opacity: animation.drive(Tween(begin: 0, end: 1)),
                child: child,
              ),
            );
          },
          child: _isLoading ? _indicatorIcon : _downIcon,
        ),
        label: const Text('Tải thêm'),
        style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          shape: const RoundedRectangleBorder(),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.lightIrisBlue,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            EmplerHomeAppBar(
              onTapSearchField: () => AppRouter.toPage(
                context,
                AppPages.searchFlcer,
                blocValue: _searchBloc,
                arguments: {
                  SearchFilterScreen.searchCateTypeArg: [
                    SearchCateType.jobCate,
                    SearchCateType.city,
                  ],
                  SearchScreen.onSearchCallbackArg: (value) => AppRouter.toPage(
                        context,
                        AppPages.listSearchFlcerResult,
                        blocValue: _searchBloc,
                      ),
                },
              ),
            ),
          ];
        },
        body: BlocBuilder<EmplerHomeBloc, EmplerHomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            _flcers = [...state.flcers];
            return RefreshIndicator(
                onRefresh: () => _homeBloc.loadData(),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(height: kSizedBoxHeight),
                    _listFlcer(),
                    const SizedBox(height: kSizedBoxHeight),
                    _button,
                  ],
                )));
          },
        ),
      ),
      floatingActionButton: _buildFAButton(
        key: _fabKey,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AppDialog(
              isShowCancelButton: true,
              padding: const EdgeInsets.only(bottom: 30.0),
              content: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 9.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kDialogBorderRadius),
                        topRight: Radius.circular(kDialogBorderRadius),
                      ),
                    ),
                    child: Text(
                      StringConst.postPost.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 28 / 20.0,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Bạn muốn đăng tin theo?',
                    style: TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 28 / 18.0,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: _buildPopupButton(
                      label: 'Dự án',
                      color: AppColors.orangeAccent,
                      onPressed: () => AppRouter.toPage(
                        context,
                        AppPages.postJobByProject,
                      ),
                    ),
                  ),
                  _buildPopupButton(
                    label: 'Bán thời gian',
                    onPressed: () =>
                        AppRouter.toPage(context, AppPages.postJobPartime),
                  ),
                  const SizedBox(height: 20.0),
                  const DotLine(),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Hướng dẫn thuê Freelancer',
                    style: TextStyle(
                      fontFamily: AppConst.fontNunito,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 28 / 18.0,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20.0),
                  _buildPopupButton(
                    label: 'Hướng dẫn',
                    onPressed: () =>
                        AppRouter.toPage(context, AppPages.hireFlcerTutorial),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  FlcerDetailCard _itemBuilder(Info flcer) {
    return FlcerDetailCard(
      id: flcer.id,
      name: flcer.name,
      location: City.fromId(flcer.cityId, list: _appRepo.cities).toString(),
      skills: flcer.listSkill.map((e) => e.toString()).toList(),
      rating: double.parse(flcer.vote ?? "0"),
      avatar: flcer.srcAvt,
      job: flcer.userJob,
      favoriteButton: flcer.savedFlc,
    );
  }

  _listFlcer() {
    return Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: CateHeader(
                header: StringConst.listFreelancer.toTitleCase(),
                onPressedArrowButton: () {
                  // _listFlcerScreen();
                },
              ),
            ),
            ..._flcers
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0 / 2),
                    child: _itemBuilder(e),
                  ),
                )
                .toList(),
          ],
        ));
  }
}
