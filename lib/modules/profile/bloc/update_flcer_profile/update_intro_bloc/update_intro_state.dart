import 'package:equatable/equatable.dart';

abstract class UpdateIntroState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateIntroInitState extends UpdateIntroState {}

class UpdateIntroErrorState extends UpdateIntroState {
  final dynamic error;

  UpdateIntroErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateIntroSuccessState extends UpdateIntroState {
  final String? message;

  UpdateIntroSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateIntroLoadState extends UpdateIntroState {}
