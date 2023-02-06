import 'package:equatable/equatable.dart';

import '../../../../utils/data/error_state_action.dart';
import '../../../../utils/data/load_state_actions.dart';

abstract class PostJobState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostJobDoneState extends PostJobState {
  PostJobDoneState();
}

class PostJobInitState extends PostJobState {}

class PostJobSErrorState extends PostJobState {
  final dynamic error;
  final ErrorStateActions action;

  PostJobSErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class PostJobLoadState extends PostJobState {
  final LoadStateActions actions;

  PostJobLoadState({
    this.actions = LoadStateActions.rebuild,
  });

  @override
  List<Object?> get props => [actions];
}
