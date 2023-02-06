import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/profile/bloc/posted_job_bloc/get_posted_job.dart';

import '../../../../utils/data/error_state_action.dart';
import '../../../../utils/data/load_state_actions.dart';

class PostedJobState extends Equatable {
  final List<PostedJob> postedJob;

  const PostedJobState({this.postedJob = const []});

  PostedJobState copywith({
    List<PostedJob>? postedJob,
  }) =>
      PostedJobState(postedJob: postedJob ?? this.postedJob);

  @override
  List<Object?> get props => [...postedJob];
}

class PostedJobErrorState extends PostedJobState {
  final dynamic error;
  final ErrorStateActions action;
  const PostedJobErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });
  @override
  List<Object?> get props => [...postedJob];
}

class PostedJobLoadState extends PostedJobState {
  final LoadStateActions onLoad;
  const PostedJobLoadState({
    this.onLoad = LoadStateActions.none,
  });

  @override
  List<Object?> get props => [onLoad];
}
