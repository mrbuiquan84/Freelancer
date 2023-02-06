import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/error_action_widget.dart';
import 'package:freelancer/common/widgets/layout/job_card.dart';
import 'package:freelancer/common/widgets/load_more_widget.dart';
import 'package:freelancer/common/widgets/load_widget.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/search/bloc/search_bloc.dart';
import 'package:freelancer/modules/search/bloc/search_state.dart';
import 'package:freelancer/modules/search/models/get_search_job_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/job_type.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

class ListSearchResultWidget extends StatefulWidget {
  const ListSearchResultWidget({Key? key}) : super(key: key);

  @override
  State<ListSearchResultWidget> createState() => _ListSearchResultWidgetState();
}

class _ListSearchResultWidgetState extends State<ListSearchResultWidget> {
  late final SearchBloc _searchBloc;
  late final AppRepo _repo;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
    _repo = context.read<AppRepo>();
  }

  @override
  void dispose() {
    _searchBloc.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: _searchBloc,
      listenWhen: (_, state) =>
          state is SearchErrorState &&
              state.action == ErrorStateActions.alert ||
          state is SearchLoadState && state.action == LoadStateActions.popup,
      listener: (_, state) {
        if (state is SearchErrorState) {
          showToast(state.error);
        }
      },
      buildWhen: (prev, state) =>
          state is SearchDoneState ||
          state is SearchLoadState &&
              state.action == LoadStateActions.rebuild ||
          state is SearchErrorState &&
              state.action == ErrorStateActions.rebuild,
      builder: (context, state) {
        if (state is SearchLoadState) {
          return const LoadWidget();
        } else if (state is SearchErrorState) {
          return ErrorActionWidget(
            error: state.error,
            onPressed: () => _searchBloc.searchJob(
              whenLoad: LoadStateActions.rebuild,
              whenError: ErrorStateActions.rebuild,
            ),
          );
        }
        final List<JobModel2> jobs = _searchBloc.jobs;
        return LoadMoreWidget(
          onLoad: _searchBloc.searchJob,
          child: ListView.separated(
            itemCount: jobs.length,
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 15.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var job = jobs[index];
              return JobCard(
                skillNames: job.listSkill.map((e) => e.toString()).toList(),
                salary: Salary.fromJob(job).toSalaryString(),
                favorite: job.savedJob,
                expDate: DateTimeExt.parse(job.dateBidEnd),
                jobId: job.id,
                emplerId: job.userId,
                skillIds: job.listSkill.map((e) => e.id).toList(),
                jobTitle: job.titleJob,
                location: job.cityName,
                emplerName: job.empName,
                emplerLogo: job.srcLogo,
                jobCate: JobCate.fromId(job.categoryId, list: _repo.jobCates)
                    .toString(),
                jobDes: job.workDes,
                detail: true,
                jobType: JobType.fromId(int.parse(job.jobType)),
                orders: job.orders,
                // orders: job.,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
          ),
        );
      },
    );
  }
}
