import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/empler/models/post_empler_detail_result.dart';

abstract class EmplerDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmplerDetailLoadState extends EmplerDetailState {}

class EmplerDetailLoadDoneState extends EmplerDetailState {
  final Info info;
  final List<InfoJob> jobs;

  EmplerDetailLoadDoneState({
    required this.info,
    required this.jobs,
  });

  @override
  List<Object?> get props => [info, ...jobs];
}

class EmplerDetailErrorState extends EmplerDetailState {
  final dynamic error;

  EmplerDetailErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
