import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';

class AuthenticationEvent {
  final AuthenticationStatus status;

  AuthenticationEvent(this.status);
}
