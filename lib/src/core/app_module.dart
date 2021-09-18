import 'package:flu_fire_auth/src/core/auth_guard.dart';
import 'package:flu_fire_auth/src/core/core_module.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/register/register_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/service/authentication_service.dart';
import 'package:flu_fire_auth/src/features/authentication/view/login_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/sign_up_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/features/bottom_navigation/controller/bottom_navigation_cubit.dart';
import 'package:flu_fire_auth/src/features/category/view/category_view.dart';
import 'package:flu_fire_auth/src/features/home/view/home_view.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_details_view.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flu_fire_auth/src/features/settings/settings_view.dart';
import 'package:flu_fire_auth/src/features/splash/controller/splash_cubit.dart';
import 'package:flu_fire_auth/src/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        Bind.singleton((i) => AuthenticationService()),
        Bind.factory((i) => AuthenticationCubit(i())),
        Bind.factory((i) => BottomNavigationCubit()),
        Bind.factory((i) => RegisterCubit(i())),
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
          child: (context, args) => BlocProvider(
            create: (context) => Modular.get<RegisterCubit>(),
            child: const SignUpPage(),
          ),
        ),
        ChildRoute(
          LoginPage.routeName,
          child: (context, args) => BlocProvider(
            create: (context) => Modular.get<RegisterCubit>(),
            child: const LoginPage(),
          ),
        ),
        ChildRoute(
          WelcomePage.routeName,
          child: (context, args) => const WelcomePage(),
        ),
        ChildRoute(
          MainView.routeName,
          child: (context, args) => const MainView(),
          children: [
            ChildRoute(
              HomeView.routeName,
              child: (context, args) => const HomeView(),
            ),
            ChildRoute(
              CategoryView.routeName,
              child: (context, args) => const CategoryView(),
            ),
          ],
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
