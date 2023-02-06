import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/profile/bloc/empler_general_bloc/post_empler_general.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

abstract class EmplerGeneralState extends Equatable {
  // final List<Data2> listJob;
  // final List<Data3> listFlcer;
  // const EmplerGeneralState(
  //     {this.listJob = const [], this.listFlcer = const []});
  @override
  List<Object?> get props => [];
}

class EmplerGeneralErrorState extends EmplerGeneralState {
  final dynamic error;
  final ErrorStateActions action;

  EmplerGeneralErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class EmplerGeneralDoneState extends EmplerGeneralState {
  final List<Data2> jobs;
  final List<Data3> flcers;
  final Data1 general;

  EmplerGeneralDoneState({
    required this.general,
    required this.jobs,
    required this.flcers,
  });

  @override
  List<Object?> get props => [
        general,
        jobs,
        flcers,
      ];
}

class EmplerGeneralLoadState extends EmplerGeneralState {
  final LoadStateActions action;

  EmplerGeneralLoadState({
    this.action = LoadStateActions.rebuild,
  });

  @override
  List<Object?> get props => [action];
}
