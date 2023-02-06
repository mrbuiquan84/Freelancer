import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/app_chip.dart';
import 'package:freelancer/common/widgets/appbar/search_appbar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/dot_line.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/helpers/context_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const onSearchCallbackArg = 'onSearchCallbackArg';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final SearchBloc _searchBloc;
  late final ValueChanged<String>? onSearch;
  late final Map<String, dynamic> args;

  @override
  void initState() {
    super.initState();
    try {
      _searchBloc = context.read<SearchBloc>();
    } catch (e) {
      _searchBloc = SearchBloc();
    }
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      args = context.routeArgs();
      onSearch =
          args[SearchScreen.onSearchCallbackArg] as ValueChanged<String>?;
    });
  }

  @override
  Widget build(BuildContext context) {
    String searchHint = 'Tìm coder thiết kế website chủ...';
    var _chipData = [
      'IT - Lập trình',
      'Hà Nội',
      'Tp. Hồ Chí Minh',
      'Thiết kế',
      'Hải Phòng',
      'Trực page online',
    ];

    var _recentSearched = [
      'Tìm coder thiết kế website chủ yếu là Landing Page',
      'Tìm coder Bùi Anh Quân',
    ];

    var scrSize = MediaQuery.of(context).size;

    _buildRecentSearchWidget() {
      var listView = ListView.separated(
        itemCount: _recentSearched.length,
        separatorBuilder: (_, __) => Column(
          children: const [
            SizedBox(height: kSizedBoxHeight),
            DotLine(),
          ],
        ),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          var iconSize = 10.0;
          return Row(
            children: [
              Expanded(
                child: Text(
                  _recentSearched[index],
                  style: AppTextStyles.textStyle,
                ),
              ),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                iconSize: iconSize,
                icon: SvgPicture.asset(
                  AppAsset.icClose,
                  color: AppColors.errorColor,
                  height: iconSize,
                  width: iconSize,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      );
      if (scrSize.width < 600.0) {
        return Container(
          constraints: const BoxConstraints(
            maxHeight: 200.0,
          ),
          child: listView,
        );
      } else {
        return Expanded(child: listView);
      }
    }

    return Scaffold(
      appBar: SearchAppBar(),
      backgroundColor: AppColors.lightIrisBlue,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(top: kScaffoldBodyVerticalPadding),
        color: AppColors.white,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    elevation: 0,
                    hint: searchHint,
                    height: 40.0,
                    prefixIcon: AppAsset.icSearch,
                    borderRadius: BorderRadius.circular(kBorderRadius10),
                    controller: _searchController,
                    contentPadding: const EdgeInsets.all(5),
                    padding: EdgeInsets.zero,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: kSizedBoxWidth),
                Material(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(kBorderRadius10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(kBorderRadius10),
                    onTap: () async {
                      await AppRouter.toPage(
                        context,
                        AppPages.filterSearch,
                        blocValue: _searchBloc,
                        arguments: args,
                      );
                      print(_searchBloc.lastSearch);
                      // setState(() {
                      //   _searchController.text =
                      //       _searchBloc.lastSearch.toString();
                      // });
                    },
                    child: Container(
                      width: 45.0,
                      height: 40.0,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppAsset.icLevels,
                        fit: BoxFit.cover,
                        height: 20.0,
                        width: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.center,
              runSpacing: 5.0,
              spacing: 5.0,
              children: _chipData
                  .map(
                    (e) => AppChip(
                      label: e,
                      labelPadding: const EdgeInsets.symmetric(
                        vertical: kChipVerticalPadding,
                        horizontal: 13.5,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: kSizedBoxHeight),
            Center(
              child: AppElevatedButton(
                label: StringConst.search,
                elevation: 0,
                width: scrSize.width * 0.4,
                labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                onPressed: () {
                  _search();
                },
              ),
            ),
            const SizedBox(height: kSizedBoxHeight),
            Text(
              StringConst.recentSearched,
              style: AppTextStyles.textStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: kSizedBoxHeight / 2),
            Expanded(child: _buildRecentSearchWidget()),
            const SizedBox(height: kSizedBoxHeight),
          ],
        ),
      ),
    );
  }

  void _search() {
    _searchBloc.searchJob(
      keyword: _searchController.text,
      whenError: ErrorStateActions.rebuild,
      whenLoad: LoadStateActions.rebuild,
    );
    if (onSearch != null) onSearch!(_searchController.text);
  }
}
