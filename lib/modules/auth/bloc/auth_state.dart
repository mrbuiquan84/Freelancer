import 'package:equatable/equatable.dart';
import 'package:freelancer/modules/auth/model/auth_status.dart';

abstract class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

class AuthUnknownState extends AuthState {
  const AuthUnknownState()
      : super(
          status: AuthStatus.unknown,
        );
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState()
      : super(
          status: AuthStatus.authed,
        );
}

class UnAuthenticatedState extends AuthState {
  final bool showIntro;
  const UnAuthenticatedState({
    this.showIntro = true,
  }) : super(
          status: AuthStatus.unAuth,
        );
}


class LoggedOutState extends AuthState {
  const LoggedOutState() : super(status: AuthStatus.authed);
}
