import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/view/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: LoginPage.routeName);

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    return await Modular.get<AuthenticationCubit>().isLogged();
  }
}
