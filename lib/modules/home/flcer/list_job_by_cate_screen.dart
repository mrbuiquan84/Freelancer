import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/models/job_model.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_drop_down_button.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/modules/search/list_search_result_widget.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/job_type.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/helpers/context_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ListJobByCateScreen extends StatefulWidget {
  const ListJobByCateScreen({
    Key? key,
    this.jobs = const [],
  }) : super(key: key);
  final List<JobModel> jobs;

  static const listJobByCateScreenArg = 'listJobByCateScreenArg';

  @override
  State<ListJobByCateScreen> createState() => _ListJobByCateScreenState();
}

class _ListJobByCateScreenState extends State<ListJobByCateScreen> {
  bool _isExtended = false;

  final _titlePadding = 2 * 14.0;
  late final JobCate jobCate;
  late final SearchBloc _searchBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = context.routeArgs();
    jobCate = args[ListJobByCateScreen.listJobByCateScreenArg];
    _searchBloc = context.read<SearchBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var _height = 40.0 * (_isExtended ? 3 : 1) + _titlePadding / 2;

    return Scaffold(
      backgroundColor: AppColors.lightIrisBlue,
      appBar: AppAppBar(
        title: Text(jobCate.toString()),
        centerTitle: true,
        extraHeight: _height,
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: EdgeInsets.only(
              top: 56.0 + _titlePadding,
              right: 20,
              left: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppDropDownButton(
                    radius: kBorderRadius10,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    iconSize: 20.0,
                    itemTextStyles: List.generate(
                      3,
                      (_) => AppTextStyles.hintTxtStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    choices: [
                      JobType(
                        id: -1,
                        jobType: StringConst.all,
                      ),
                      ...JobType.values
                    ],
                    onTap: (JobType jobType) {
                      setState(() {
                        _isExtended = !_isExtended;
                      });
                      if (jobType.id == -1) {
                        _searchBloc.lastSearch.type = null;
                      } else {
                        _searchBloc.lastSearch.type = jobType;
                      }
                      _searchBloc.reset();
                      _searchBloc.searchJob(
                        whenError: ErrorStateActions.rebuild,
                        whenLoad: LoadStateActions.rebuild,
                      );
                    },
                    onExpand: () {
                      setState(() {
                        _isExtended = !_isExtended;
                      });
                    },
                    itemHeight: 40.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(kBorderRadius10),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    AppAsset.icLevels,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: kScaffoldBodyVerticalPadding),
        color: AppColors.white,
        height: double.infinity,
        child: Center(
          child: BlocProvider.value(
            value: _searchBloc,
            child: const ListSearchResultWidget(),
          ),
        ),
      ),
    );
  }
}
