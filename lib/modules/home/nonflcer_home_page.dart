import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/cate_data.dart';
import 'package:freelancer/common/models/job_model.dart';
import 'package:freelancer/common/widgets/appbar/home_appbar.dart';
import 'package:freelancer/common/widgets/appbar/nonuser_home_appbar.dart';
import 'package:freelancer/common/widgets/button/cate_button.dart';
import 'package:freelancer/common/widgets/cate_header_widget.dart';
import 'package:freelancer/common/widgets/layout/job_card.dart';
import 'package:freelancer/modules/home/flcer/list_job_by_cate_screen.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/home/flcer/bloc/flcer_home_bloc.dart';
import 'package:freelancer/modules/home/flcer/bloc/flcer_home_state.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/modules/search/search_filter_screen.dart';
import 'package:freelancer/modules/search/search_screen.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/city.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/job_type.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/data/search_cate_type.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class NonFlcerHomePage extends StatefulWidget {
  const NonFlcerHomePage({Key? key}) : super(key: key);

  @override
  State<NonFlcerHomePage> createState() => _NonFlcerHomeState();
}

class _NonFlcerHomeState extends State<NonFlcerHomePage> {
  late final FlcerHomeBloc _homeBloc;
  late final AppRepo _appRepo;
  List<JobModel> _jobByProjects = [];
  List<JobModel> _jobParttimes = [];
  late final SearchBloc _searchBloc;
  late final SearchBloc _searchByJobTypeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<FlcerHomeBloc>();
    _appRepo = context.read<AppRepo>();
    _searchBloc = SearchBloc();
    _searchByJobTypeBloc = SearchBloc();
  }

  void _toListJobByJobTypeScreen({
    required JobType jobType,
  }) {
    _searchByJobTypeBloc.lastSearch
      ..type = jobType
      ..page = 1;
    _searchByJobTypeBloc.searchJob(
      whenError: ErrorStateActions.rebuild,
      whenLoad: LoadStateActions.rebuild,
    );
    AppRouter.toPage(
      context,
      AppPages.listJobByJobType,
      blocValue: _searchByJobTypeBloc,
    ).then((value) => _searchByJobTypeBloc.reset());
  }

  _jobByProject() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: CateHeader(
              header: StringConst.jobFlcerByProject.toTitleCase(),
              onPressedArrowButton: () {
                _toListJobByJobTypeScreen(jobType: JobType.projectType);
              },
            ),
          ),
          ..._jobByProjects
              .map(
                (job) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0 / 2),
                  child: _buildJobCard(job),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  JobCard _buildJobCard(JobModel job) {
    return JobCard(
      jobType: JobType.fromId(int.parse(job.jobType)),
      jobId: job.id,
      emplerId: job.userId,
      expDate: job.dateBidEnd,
      emplerName: job.name,
      favorite: job.savedJob,
      jobTitle: job.titleJob,
      location: City.fromId(job.workCity, list: _appRepo.cities).toString(),
      salary: Salary.fromJob(job).toSalaryString(),
      skillNames: job.listSkill.map((e) => e.toString()).toList(),
      skillIds: job.listSkill.map((e) => e.id).toList(),
    );
  }

  _jobByParttime() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: CateHeader(
              header: StringConst.jobFlcerByParttime.toTitleCase(),
              onPressedArrowButton: () =>
                  _toListJobByJobTypeScreen(jobType: JobType.parttimeType),
            ),
          ),
          ..._jobParttimes
              .map(
                (job) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0 / 2),
                  child: _buildJobCard(job),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  final _jobByCate = const _ListJobCateButton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightIrisBlue,
      // appBar: HomeAppBar(
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            NonUserHomeAppBar(
              onTapSearchField: () => AppRouter.toPage(
                context,
                AppPages.search,
                blocValue: _searchBloc,
                arguments: {
                  SearchFilterScreen.searchCateTypeArg: [
                    SearchCateType.jobCate,
                    SearchCateType.city,
                  ],
                  SearchScreen.onSearchCallbackArg: (value) => AppRouter.toPage(
                        context,
                        AppPages.listSearchResult,
                        blocValue: _searchBloc,
                      ),
                },
              ),
            ),
          ];
        },
        body: BlocBuilder<FlcerHomeBloc, FlcerHomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            _jobByProjects = [...state.jobByProjects];
            _jobParttimes = [...state.jobParttimes];
            return RefreshIndicator(
              onRefresh: () => _homeBloc.loadData2(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: kScaffoldBodyVerticalPadding),
                    _jobByCate,
                    const SizedBox(height: kSizedBoxHeight),
                    _jobByProject(),
                    const SizedBox(height: kSizedBoxHeight),
                    _jobByParttime(),
                    const SizedBox(height: kScaffoldBodyVerticalPadding)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListJobCateButton extends StatefulWidget {
  const _ListJobCateButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_ListJobCateButton> createState() => _ListJobCateButtonState();
}

class _ListJobCateButtonState extends State<_ListJobCateButton> {
  late final AppRepo _appRepo;
  late final SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _appRepo = context.read<AppRepo>();
    _searchBloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
      color: AppColors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 15.0,
            ),
            child: CateHeader(
              header: StringConst.jobByField.toTitleCase(),
              showArrowButton: false,
            ),
          ),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 86 / 100,
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: kPadding(context) / 20 * 12),
            shrinkWrap: true,
            children: _appRepo.jobCates.asMap().entries.map(
              (e) {
                var id = e.key;
                var jobCate = e.value;
                return CateButton(
                  data: CateData.fromCate(jobCate),
                  color: [1, 3, 4, 6, 9, 11].contains(id)
                      ? AppColors.orangeAccent
                      : null,
                  onPressed: () {
                    _searchBloc.lastSearch
                      ..categoryId = jobCate
                      ..type = null;
                    _searchBloc.searchJob(
                      whenError: ErrorStateActions.rebuild,
                      whenLoad: LoadStateActions.rebuild,
                    );
                    AppRouter.toPage(
                      context,
                      AppPages.listJob,
                      arguments: {
                        ListJobByCateScreen.listJobByCateScreenArg: jobCate,
                      },
                      blocValue: _searchBloc,
                    ).then((value) => _searchBloc.reset());
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
