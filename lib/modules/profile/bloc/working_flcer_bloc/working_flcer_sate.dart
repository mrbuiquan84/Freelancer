import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class WorkingFlcerState extends Equatable {
  final List<FlcWorking> workingFlcer;

  const WorkingFlcerState({this.workingFlcer = const []});

  WorkingFlcerState copywith({
    List<FlcWorking>? workingflcer,
  }) =>
      WorkingFlcerState(workingFlcer: workingflcer ?? this.workingFlcer);

  @override
  List<Object?> get props => [...workingFlcer];
}

class WorkingFlcerLoadState extends WorkingFlcerState {
  final LoadStateActions onLoad;
  const WorkingFlcerLoadState({
    this.onLoad = LoadStateActions.none,
  });
  @override
  List<Object?> get props => [...workingFlcer];
}

class WorkingFlcerErrorState extends WorkingFlcerState {
  final dynamic error;
  final ErrorStateActions actions;

  const WorkingFlcerErrorState(
    this.error, {
    this.actions = ErrorStateActions.rebuild,
  });
  @override
  List<Object?> get props => [error, actions];
}
