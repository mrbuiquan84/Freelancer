import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/auth/model/auth_status.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  final AuthStatus status;

  AuthStatusChanged(this.status);
  @override
  List<Object?> get props => [status];
}

class AuthLogoutRequest extends AuthEvent {}
