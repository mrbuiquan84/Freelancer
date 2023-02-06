import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/profile/models/get_saved_ongoing_project_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class SavedProjectState extends Equatable {
  final List<FlcSaveJob> savedJobs;

  const SavedProjectState({this.savedJobs = const []});

  @override
  List<Object?> get props => [...savedJobs];
}

class SavedProjectLoadState extends SavedProjectState {
  final LoadStateActions onLoad;

  const SavedProjectLoadState({
    this.onLoad = LoadStateActions.none,
  });
  @override
  List<Object?> get props => [onLoad];
}

class SavedProjectErrorState extends SavedProjectState {
  final dynamic error;
  final ErrorStateActions action;

  const SavedProjectErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class SavedProjectDeleteSuccessState extends SavedProjectState {
  final String deletedJobId;

  const SavedProjectDeleteSuccessState(this.deletedJobId);
  @override
  List<Object?> get props => [deletedJobId];
}
