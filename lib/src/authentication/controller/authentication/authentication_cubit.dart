import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_fire_auth/src/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/authentication/service/authentication_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._authenticationService)
      : super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription =
        _authenticationService.status.listen(_onAuthenticationStatusChanged);
  }

  final AuthenticationService _authenticationService;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  void _onAuthenticationStatusChanged(AuthenticationStatus status) =>
      statusChanged(status);

  void statusChanged(final AuthenticationStatus status) async {
    if (status == AuthenticationStatus.authenticated) {
      final accessToken = await _authenticationService.accessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        emit(AuthenticationState.authenticated(accessToken));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  void logoutRequested() async {
    _authenticationService.logOut();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationService.dispose();
    return super.close();
  }
}
