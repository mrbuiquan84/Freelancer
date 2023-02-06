import 'package:equatable/equatable.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

abstract class EmplerProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmplerProfileDoneState extends EmplerProfileState {
  EmplerProfileDoneState();
}

class EmplerProfileErrorState extends EmplerProfileState {
  final dynamic error;
  final ErrorStateActions action;

  EmplerProfileErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class EmplerProfileLoadState extends EmplerProfileState {
  final LoadStateActions actions;

  EmplerProfileLoadState({
    this.actions = LoadStateActions.rebuild,
  });

  @override
  List<Object?> get props => [actions];
}
