import 'package:flu_fire_auth/src/core/auth_guard.dart';
import 'package:flu_fire_auth/src/core/core_module.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/service/authentication_service.dart';
import 'package:flu_fire_auth/src/features/authentication/view/login_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/sign_up_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_details_view.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flu_fire_auth/src/features/settings/settings_view.dart';
import 'package:flu_fire_auth/src/features/splash/controller/splash_cubit.dart';
import 'package:flu_fire_auth/src/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind> get binds => [
        // Demo service
        AsyncBind<DemoSampleService>((i) => DemoSampleService().init()),
        Bind.singleton((i) => SplashCubit()),
        Bind((i) => AuthenticationService()),
        Bind((i) => AuthenticationService()),
        Bind.factory((i) => AuthenticationCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          SplashView.routeName,
          child: (context, args) => const SplashView(),
        ),
        ChildRoute(
          SettingsView.routeName,
          child: (context, args) => SettingsView(controller: args.data),
          guards: [AuthGuard()],
        ),
        ChildRoute(
          SampleItemDetailsView.routeName,
          child: (context, args) => const SampleItemDetailsView(),
        ),
        ChildRoute(
          SampleItemListView.routeName,
          child: (context, args) => const SampleItemListView(),
          guards: [AuthGuard()],
        ),
        ChildRoute(
          SignUpPage.routeName,
          child: (context, args) => const SignUpPage(),
        ),
        ChildRoute(
          LoginPage.routeName,
          child: (context, args) => const LoginPage(),
        ),
        ChildRoute(
          WelcomePage.routeName,
          child: (context, args) => const WelcomePage(),
        ),
        WildcardRoute(
          child: (context, args) => Container(),
        ),
      ];
}

class DemoSampleService {
  Future<DemoSampleService> init() async {
    await Future.delayed(const Duration(seconds: 10));
    return this;
  }
}
