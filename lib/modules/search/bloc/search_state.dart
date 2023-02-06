import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/search/models/get_search_job_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchLoadState extends SearchState {
  final LoadStateActions action;

  SearchLoadState({this.action = LoadStateActions.none});
  @override
  List<Object?> get props => [action];
}

class SearchDoneState extends SearchState {
  final List<JobModel2> jobs;

  SearchDoneState({this.jobs = const []});
  @override
  List<Object?> get props => [...jobs];
}

class SearchErrorState extends SearchState {
  final ErrorStateActions action;
  final dynamic error;

  SearchErrorState(this.error, {this.action = ErrorStateActions.alert});
  @override
  List<Object?> get props => [error, action];
}
