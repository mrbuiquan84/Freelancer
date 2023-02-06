import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class SavedFlcerCardState extends Equatable {
  final List<SavedFlc> savedFlcer;

  const SavedFlcerCardState({this.savedFlcer = const []});

  SavedFlcerCardState copywith({
    List<SavedFlc>? savedflcers,
  }) =>
      SavedFlcerCardState(savedFlcer: savedflcers ?? this.savedFlcer);

  @override
  List<Object?> get props => [...savedFlcer];
}

class SavedFlcerLoadState extends SavedFlcerCardState {
  final LoadStateActions onLoad;
  const SavedFlcerLoadState({
    this.onLoad = LoadStateActions.none,
  });
  @override
  List<Object?> get props => [...savedFlcer];
}

class SaveFlcerErrorState extends SavedFlcerCardState {
  final dynamic error;
  final ErrorStateActions actions;

  const SaveFlcerErrorState(
    this.error, {
    this.actions = ErrorStateActions.rebuild,
  });
  @override
  List<Object?> get props => [error, actions];
}

class SaveFlcerDeleteSuccessState extends SavedFlcerCardState {
  final String deleteFlcerId;

  const SaveFlcerDeleteSuccessState(this.deleteFlcerId);
  @override
  List<Object?> get props => [deleteFlcerId];
}
