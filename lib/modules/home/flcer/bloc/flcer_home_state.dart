import 'package:equatable/equatable.dart';
import 'package:freelancer/common/models/job_model.dart';

class FlcerHomeState extends Equatable {
  final List<JobModel> jobByProjects;
  final List<JobModel> jobParttimes;

  const FlcerHomeState({
    this.jobByProjects = const [],
    this.jobParttimes = const [],
  });

  FlcerHomeState copyWith({
    List<JobModel>? jobByProjects,
    List<JobModel>? jobParttimes,
  }) =>
      FlcerHomeState(
        jobByProjects: jobByProjects ?? this.jobByProjects,
        jobParttimes: jobParttimes ?? this.jobParttimes,
      );

  @override
  List<Object?> get props => [...jobByProjects, ...jobParttimes];
}

class FlcerHomeLoadState extends FlcerHomeState {}

class FlcerHomeLoadDoneState extends FlcerHomeState {
  const FlcerHomeLoadDoneState();
  // @override
  // List<Object?> get props => [...jobByProjects, ...jobParttimes];
}

class FlcerHomeErrorState extends FlcerHomeState {
  final dynamic error;

  const FlcerHomeErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
