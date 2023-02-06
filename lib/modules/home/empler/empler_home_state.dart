import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/home/empler/get_empler_home_data_result.dart';

class EmplerHomeState extends Equatable {
  final List<Info> flcers;

  const EmplerHomeState({
    this.flcers = const [],
  });
  EmplerHomeState copyWith({
    List<Info>? flcers,
  }) =>
      EmplerHomeState(
        flcers: flcers ?? this.flcers,
      );
  @override
  List<Object?> get props => [...flcers];
}

class EmplerHomeLoadState extends EmplerHomeState {}

class EmplerHomeLoadDoneState extends EmplerHomeState {
  const EmplerHomeLoadDoneState();
}

class EmplerHomeErrorState extends EmplerHomeState {
  final dynamic error;
  const EmplerHomeErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
