part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String? accessToken;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.accessToken = '',
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(String accessToken)
      : this._(
          status: AuthenticationStatus.authenticated,
          accessToken: accessToken,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status];
}
