import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitState extends SignupState {}

class SignupErrorState extends SignupState {
  final dynamic error;

  SignupErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class SignupSuccessState extends SignupState {
  final String? message;

  SignupSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class SignupLoadState extends SignupState {}

class SignupReceivedOTPState extends SignupState {
  final String token;

  SignupReceivedOTPState({required this.token});

  @override
  List<Object?> get props => [token];
}

class SignupEmplerReceivedOTPState extends SignupState {
  final String token;

  SignupEmplerReceivedOTPState({required this.token});

  @override
  List<Object?> get props => [token];
}
