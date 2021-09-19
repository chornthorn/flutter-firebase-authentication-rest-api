import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_fire_auth/main.dart';
import 'package:flu_fire_auth/src/core/app_event/authentication_event.dart';
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/service/authentication_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._authenticationService)
      : super(const AuthenticationState.loading()) {
    _authenticationStatusSubscription =
        _authenticationService.status.listen(_onAuthenticationStatusChanged);
  }

  final AuthenticationService _authenticationService;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  void _onAuthenticationStatusChanged(AuthenticationStatus status) =>
      _statusChanged(status);

  void _statusChanged(final AuthenticationStatus status) async {
    if (status == AuthenticationStatus.authenticated) {
      final accessToken = await _authenticationService.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        emit(AuthenticationState.authenticated(accessToken));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  void onLogged() {
    _authenticationService.logged();
  }

  void logoutRequested() async {
    _authenticationService.logOut();
    eventBus.fire(AuthenticationEvent(AuthenticationStatus.unauthenticated));
  }

  Future<bool> isLogged() async {
    final result = await _authenticationService.getAccessToken();
    if (result != null) return true;
    return false;
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationService.dispose();
    return super.close();
  }
}
