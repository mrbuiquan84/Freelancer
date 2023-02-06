import 'package:equatable/equatable.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

abstract class FlcerProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FlcerProfileDoneState extends FlcerProfileState {
  // final Info info;

  FlcerProfileDoneState();
}

class FlcerProfileErrorState extends FlcerProfileState {
  final dynamic error;
  final ErrorStateActions action;

  FlcerProfileErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class FlcerProfileLoadState extends FlcerProfileState {
  final LoadStateActions action;

  FlcerProfileLoadState({
    this.action = LoadStateActions.rebuild,
  });

  @override
  List<Object?> get props => [action];
}
