import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/search_appbar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/modules/search/list_filter_items_widget.dart';
import 'package:freelancer/modules/search/search_screen.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/search_cate_type.dart';
import 'package:freelancer/utils/helpers/context_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_text_styles.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({
    Key? key,
  }) : super(key: key);

  static const searchCateTypeArg = 'searchCateTypeArg';

  @override
  Widget build(BuildContext context) {
    var args = context.routeArgs();
    final List<SearchCateType> searchCateType = args[searchCateTypeArg];
    final AppRepo repo = context.read<AppRepo>();
    final searchBloc = context.read<SearchBloc>();

    final listCates = [];
    final listData = [];
    final listCateTypes = [];
    final List<List> _filtered = [];
    var lastSearch = searchBloc.lastSearch;

    if (searchCateType.contains(SearchCateType.jobCate)) {
      listCates.add(StringConst.jobCate);
      listData.add(repo.jobCates);
      listCateTypes.add(SearchCateType.jobCate);
      _filtered.add([lastSearch.categoryId]);
    }

    if (searchCateType.contains(SearchCateType.city)) {
      listCates.add(StringConst.city);
      listData.add(repo.cities);
      listCateTypes.add(SearchCateType.city);
      _filtered.add([lastSearch.workCity]);
    }

    if (searchCateType.contains(SearchCateType.skill)) {
      listCates.add(StringConst.skill);
      listData.add([]);
      listCateTypes.add(SearchCateType.skill);
      _filtered.add([lastSearch.skillId]);
    }

    var _labelTextStyle = const TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      height: 24.0 / 16.0,
    );

    return Scaffold(
      appBar: SearchAppBar(),
      backgroundColor: AppColors.lightIrisBlue,
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: kScaffoldBodyVerticalPadding,
              ),
              height: double.maxFinite,
              width: double.infinity,
              color: AppColors.backgroundColor,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        StringConst.filterSearch,
                        textHeightBehavior: AppConst.textHeightBehavior,
                        style: _labelTextStyle.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 3.0,
                      color: AppColors.dividerColor,
                    ),
                    ...listCates.asMap().entries.map(
                      (e) {
                        var index = e.key;
                        var cate = e.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: ListFilterItemsWidget(
                            cate: cate,
                            items: listData[index],
                            selectedItems: _filtered[index],
                            onChanged: (List value) {
                              _filtered[index] = [...value];
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            child: AppElevatedButton(
              // firstLabel: StringConst.cancel,
              label: StringConst.filterSearch,
              elevation: 0,
              height: 40.0,
              width: MediaQuery.of(context).size.width * 0.6,
              labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
              // labelTextStyle: _labelTextStyle,
              onPressed: () {
                if (listCateTypes.contains(SearchCateType.city)) {
                  try {
                    var cityId = listCateTypes
                        .indexWhere((e) => e == SearchCateType.city);
                    var city = _filtered[cityId];
                    searchBloc.lastSearch.workCity = city.last;
                  } catch (_) {}
                }
                if (listCateTypes.contains(SearchCateType.jobCate)) {
                  try {
                    var jobCateId = listCateTypes
                        .indexWhere((e) => e == SearchCateType.jobCate);
                    var jobCate = _filtered[jobCateId];
                    searchBloc.lastSearch.categoryId = jobCate.last;
                  } catch (_) {}
                }
                if (listCateTypes.contains(SearchCateType.skill)) {
                  try {
                    var skillId = listCateTypes
                        .indexWhere((e) => e == SearchCateType.skill);
                    var skill = _filtered[skillId];
                    searchBloc.lastSearch.skillId = skill.last;
                  } catch (_) {}
                }
                AppRouter.back(context);
              },
              // onPressedFirstButton:  AppRouter.backToPage(context, SearchScreen());
            ),
          ),
        ],
      ),
    );
  }
}
