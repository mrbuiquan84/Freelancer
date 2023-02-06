import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/jobcate/jobcate_state.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/modules/search/bloc/search_flcer_bloc.dart';
import 'package:freelancer/utils/helpers/context_extension.dart';

import '../../../common/bloc/jobcate/select_job_bloc.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/app_elevated_button.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../router/app_router.dart';
import '../../../utils/data/search_cate_type.dart';
import '../../../utils/ui/app_num.dart';
import '../../bloc/app_repo.dart';
import '../bloc/search_bloc.dart';
import '../list_filter_items_widget.dart';

class SearchFillerFlcerScreen extends StatefulWidget {
  const SearchFillerFlcerScreen({Key? key}) : super(key: key);

  static const searchCateTypeArg = 'searchCateTypeArg';

  @override
  State<SearchFillerFlcerScreen> createState() =>
      _SearchFillerFlcerScreenState();
}

class _SearchFillerFlcerScreenState extends State<SearchFillerFlcerScreen> {
  @override
  Widget build(BuildContext context) {
    var args = context.routeArgs();
    final List<SearchCateType> searchCateType =
        args[SearchFillerFlcerScreen.searchCateTypeArg];
    final AppRepo repo = context.read<AppRepo>();
    final searchBloc = context.read<SearchFlcerBloc>();

    final listCates = [];
    final listData = [];
    final listCateTypes = [];
    final List<List> _filtered = [];
    var lastSearch = searchBloc.lastSearch;

    listCates.add("Loại");
    listData.add(["Xuất sắc", "Mới nhất"]);
    listCateTypes.add(SearchCateType.skill);
    _filtered.add([lastSearch.skillId]);

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
    JobCate? _selectedJob;
    var jobBloc = JobBloc(
      JobcateLoadState(),
      appRepo: repo,
    );
    // jobBloc.getSkill(_selectedjob!.jobId);
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
      appBar: AppAppBar(
        title: const Text(
          "Freelancer",
          textHeightBehavior: TextHeightBehavior(
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        centerTitle: true,
      ),
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
                        "Lọc Freelancer",
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
            ),
          ),
        ],
      ),
    );
  }
}
