import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/profile/models/get_saved_ongoing_project_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class OngoingProjectState extends Equatable {
  final List<FlcGoingJob> goingJob;

  const OngoingProjectState({this.goingJob = const []});
  @override
  List<Object?> get props => [...goingJob];
}

class OngoingProjectErrorState extends OngoingProjectState {
  final dynamic error;
  final ErrorStateActions action;
  const OngoingProjectErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class OngoingProjectLoadState extends OngoingProjectState {
  final LoadStateActions onLoad;
  const OngoingProjectLoadState({
    this.onLoad = LoadStateActions.none,
  });

  @override
  List<Object?> get props => [onLoad];
}
