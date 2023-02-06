import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';

class HadSetPriceState extends Equatable {
  final List<FlcPrice> flcerPrice;

  const HadSetPriceState({this.flcerPrice = const []});

  HadSetPriceState copywith({
    List<FlcPrice>? flcerPrice,
  }) =>
      HadSetPriceState(flcerPrice: flcerPrice ?? this.flcerPrice);

  @override
  List<Object?> get props => [...flcerPrice];
}

class HadSetPriceLoadState extends HadSetPriceState {
  final LoadStateActions onLoad;
  const HadSetPriceLoadState({
    this.onLoad = LoadStateActions.none,
  });
  @override
  List<Object?> get props => [...flcerPrice];
}

class HadSetPriceErrorState extends HadSetPriceState {
  final dynamic error;
  final ErrorStateActions actions;

  const HadSetPriceErrorState(
    this.error, {
    this.actions = ErrorStateActions.rebuild,
  });
  @override
  List<Object?> get props => [error, actions];
}
