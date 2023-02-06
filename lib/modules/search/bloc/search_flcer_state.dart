import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/search/models/search_flcer_input_model.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

import '../../../utils/data/error_state_action.dart';

class SearchFlcerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFlcerLoadState extends SearchFlcerState {
  final LoadStateActions action;

  SearchFlcerLoadState({this.action = LoadStateActions.none});

  @override
  List<Object?> get props => [action];
}

class SearchFlcerDoneState extends SearchFlcerState {
  final List<SearchFlcerInputModel> flcers;
  SearchFlcerDoneState({this.flcers = const []});

  @override
  List<Object?> get props => [...flcers];
}

class SearchFlcerErrorState extends SearchFlcerState {
  final ErrorStateActions action;
  final dynamic error;

  SearchFlcerErrorState(this.error, {this.action = ErrorStateActions.alert});
  @override
  List<Object?> get props => [error, action];
}
