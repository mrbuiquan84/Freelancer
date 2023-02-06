import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/header.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/get_posted_job.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/posted_job_bloc.dart';
import 'package:freelancer/modules/profile/widget/post_card.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../common/widgets/error_action_widget.dart';
import '../../../common/widgets/load_widget.dart';
import '../../../utils/data/error_state_action.dart';
import '../../../utils/data/load_state_actions.dart';
import '../../../utils/ui/show_load_dialog.dart';
import '../../../utils/ui/show_toast.dart';
import '../bloc/posted_job_bloc/posted_job_state.dart';

class PostedJobScreen extends StatefulWidget {
  const PostedJobScreen({Key? key}) : super(key: key);

  @override
  State<PostedJobScreen> createState() => _PostedJobScreenState();
}

class _PostedJobScreenState extends State<PostedJobScreen> {
  @override
  Widget build(BuildContext context) {
    List<PostedJob> listJobs = [];
    final postedJobBloc = context.read<PostedJobBloc>();
    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.postedPost.toTitleCase()),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Padding(
        padding: const EdgeInsets.only(
          top: kScaffoldBodyVerticalPadding,
        ),
        child: BlocConsumer<PostedJobBloc, PostedJobState>(
          bloc: postedJobBloc,
          listener: (_, state) {
            if (state is PostedJobLoadState &&
                state.onLoad == LoadStateActions.popup) {
              showLoadDialog(context);
            } else if (state is PostedJobErrorState &&
                state.action == ErrorStateActions.alert) {
              showToast(state.error.toString());
            }
          },
          buildWhen: (_, state) {
            var c1 = state.runtimeType == PostedJobState;
            var c2 = (state is PostedJobErrorState &&
                state.action == ErrorStateActions.rebuild);
            var c3 = (state is PostedJobLoadState &&
                state.onLoad == LoadStateActions.rebuild);
            var rebuildCondition = c1 || c2 || c3;
            return rebuildCondition;
          },
          builder: (_, state) {
            if (state is PostedJobErrorState) {
              return ErrorActionWidget(
                error: state.error.toString(),
                onPressed: postedJobBloc.initLoad,
              );
            } else if (state is PostedJobLoadState) {
              return const LoadWidget();
            }
            listJobs = postedJobBloc.jobs;
            return RefreshIndicator(
              onRefresh: () => postedJobBloc.getPostedJob(),
              backgroundColor: AppColors.white,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kPadding(context),
                ),
                child: Column(
                  children: [
                    Header(header: StringConst.postedPost),
                    ...listJobs
                        .map(
                          (e) => PostCard(
                            job: e,
                            margin: const EdgeInsets.only(bottom: 20.0),
                          ),
                        )
                        .toList(),
                  ],
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}
