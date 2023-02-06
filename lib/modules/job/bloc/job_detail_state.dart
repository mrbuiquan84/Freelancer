import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/job/model/post_job_detail_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

abstract class JobDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class JobDetailLoadState extends JobDetailState {
  final LoadStateActions action;
  JobDetailLoadState({
    this.action = LoadStateActions.rebuild,
  });
  @override
  List<Object?> get props => [action];
}

class JobDetailDoneState extends JobDetailState {
  final JobDetail info;
  final List<JobsSame> jobsSame;
  final List<ListsFlc> listsFlc;

  JobDetailDoneState({
    required this.info,
    required this.jobsSame,
    required this.listsFlc,
  });

  @override
  List<Object?> get props => [
        info,
        jobsSame,
        listsFlc,
      ];
}

class JobDetailErrorState extends JobDetailState {
  final ErrorStateActions action;
  final dynamic error;
  JobDetailErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });
}
