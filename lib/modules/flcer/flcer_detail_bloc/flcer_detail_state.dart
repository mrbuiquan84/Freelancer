import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/flcer/flcer_detail_bloc/post_flcer_detail_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

abstract class FlcerDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FlcerDetailLoadState extends FlcerDetailState {
  final LoadStateActions action;
  FlcerDetailLoadState({
    this.action = LoadStateActions.rebuild,
  });
  @override
  List<Object?> get props => [action];
}

class FlcerDetailDoneState extends FlcerDetailState {
  final Info info;

  FlcerDetailDoneState({required this.info});

  @override
  List<Object?> get props => [info];
}

class FlcerDetailErrorState extends FlcerDetailState {
  final ErrorStateActions action;
  final dynamic error;
  FlcerDetailErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });
}
