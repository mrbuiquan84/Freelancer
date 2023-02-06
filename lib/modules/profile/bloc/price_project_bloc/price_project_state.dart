import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/profile/models/get_price_project_result.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class PriceProjectState extends Equatable {
  final List<PriceProject> priceProject;

  const PriceProjectState({this.priceProject = const []});

  List<Object?> get props => [...priceProject];
}

class PriceProjectErrorState extends PriceProjectState {
  final dynamic error;
  final ErrorStateActions action;
  const PriceProjectErrorState(
    this.error, {
    this.action = ErrorStateActions.rebuild,
  });

  @override
  List<Object?> get props => [error, action];
}

class PriceProjectLoadState extends PriceProjectState {
  final LoadStateActions onLoad;

  const PriceProjectLoadState({
    this.onLoad = LoadStateActions.none,
  });

  @override
  List<Object?> get props => [onLoad];
}
