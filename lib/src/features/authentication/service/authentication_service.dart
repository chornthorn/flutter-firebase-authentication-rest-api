import 'dart:async';

import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield* _checkToken();
  }

  Stream<AuthenticationStatus> _checkToken() async* {
    final result = await accessToken();
    if (result != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
  }

  void logged() {
    return _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<String?> accessToken() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final result = sp.getString('accessToken');
      if (result != null) return result;
      return null;
    } catch (e) {
      return null;
    }
  }

  void dispose() => _controller.close();
}
