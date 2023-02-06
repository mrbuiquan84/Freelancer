import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitState extends ForgotPasswordState {}

class ForgotPasswordLoadState extends ForgotPasswordState {}

class ForgotPasswordConfirmedOTPState extends ForgotPasswordState {}

class ForgotPasswordRecievedOTPState extends ForgotPasswordState {
  final String token;

  ForgotPasswordRecievedOTPState({
    required this.token,
  });
  @override
  List<Object?> get props => [token];
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String? error;

  ForgotPasswordErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class ForgotPasswordSuccessState extends ForgotPasswordState {}
