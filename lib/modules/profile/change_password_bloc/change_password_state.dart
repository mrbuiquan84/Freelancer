import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitState extends ChangePasswordState {}

class ChangePasswordLoadState extends ChangePasswordState {}

class ChangePasswordConfirmedOTPState extends ChangePasswordState {}

class ChangePasswordRecievedOTPState extends ChangePasswordState {
  final String token;

  ChangePasswordRecievedOTPState({
    required this.token,
  });
  @override
  List<Object?> get props => [token];
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String? error;

  ChangePasswordErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ChangePasswordSuccessState extends ChangePasswordState {}
