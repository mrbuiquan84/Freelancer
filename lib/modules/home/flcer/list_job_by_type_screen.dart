import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/modules/search/list_search_result_widget.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/job_type.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ListJobByJobTypeScreen extends StatefulWidget {
  const ListJobByJobTypeScreen({Key? key}) : super(key: key);

  @override
  State<ListJobByJobTypeScreen> createState() => _ListJobByJobTypeScreenState();
}

class _ListJobByJobTypeScreenState extends State<ListJobByJobTypeScreen> {
  final _searchController = TextEditingController();

  final double _textFieldHeight = 40;
  final double _textFieldPadding = 15;

  late final SearchBloc _searchBloc;
  late final JobType _jobType;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
    _jobType = _searchBloc.lastSearch.type ?? JobType.parttimeType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightIrisBlue,
      appBar: AppAppBar(
        title: Text(
          (_jobType == JobType.parttimeType
                  ? StringConst.jobByParttime
                  : StringConst.jobByProject)
              .toTitleCase(),
        ),
        centerTitle: true,
        extraHeight: _textFieldHeight + _textFieldPadding,
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: EdgeInsets.only(
              top: kStatusbarHeight + _textFieldHeight + _textFieldPadding,
              right: 20,
              left: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'Nhập từ khóa, ngành nghề...',
                    height: 40,
                    prefixIcon: AppAsset.icSearch,
                    controller: _searchController,
                    padding: EdgeInsets.zero,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      _searchBloc.reset();
                      _searchBloc.searchJob(
                        keyword: value,
                        whenError: ErrorStateActions.rebuild,
                        whenLoad: LoadStateActions.rebuild,
                      );
                    },
                  ),
                ),
                const SizedBox(width: kSizedBoxWidth),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: InkWell(
                    child: Container(
                      width: 40,
                      height: 40.0,
                      color: AppColors.primaryColor,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppAsset.icLevels,
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: kScaffoldBodyVerticalPadding),
        color: AppColors.white,
        height: double.infinity,
        child: const ListSearchResultWidget(),
      ),
    );
  }
}
