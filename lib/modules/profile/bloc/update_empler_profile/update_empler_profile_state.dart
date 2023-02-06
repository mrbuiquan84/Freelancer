import 'package:equatable/equatable.dart';

abstract class UpdateEmplerProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateEmplerProfileInitState extends UpdateEmplerProfileState {}

class UpdateEmplerProfileErrorState extends UpdateEmplerProfileState {
  final dynamic error;
  UpdateEmplerProfileErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateEmplerProfileSuccessState extends UpdateEmplerProfileState {
  final String? message;

  UpdateEmplerProfileSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateEmplerProfileLoadState extends UpdateEmplerProfileState {}
