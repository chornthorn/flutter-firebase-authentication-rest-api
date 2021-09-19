import 'package:flu_fire_auth/src/core/auth_guard.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/register/register_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/user_info/user_info_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/service/authentication_service.dart';
import 'package:flu_fire_auth/src/features/authentication/view/login_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/sign_up_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/verify_account_view.dart';
import 'package:flu_fire_auth/src/features/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/features/bottom_navigation/controller/bottom_navigation_cubit.dart';
import 'package:flu_fire_auth/src/features/category/view/category_view.dart';
import 'package:flu_fire_auth/src/features/home/view/home_view.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_details_view.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flu_fire_auth/src/features/settings/view/settings_view.dart';
import 'package:flu_fire_auth/src/features/splash/controller/splash_cubit.dart';
import 'package:flu_fire_auth/src/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        AsyncBind<SharedPreferences>(
            (i) async => SharedPreferences.getInstance()),
        Bind.factory((i) => SplashCubit()),
        Bind.singleton((i) => AuthenticationService()),
        Bind.factory((i) => AuthenticationCubit(i())),
        Bind.factory((i) => BottomNavigationCubit()),
        Bind.singleton((i) => UserInfoCubit(i())),
        Bind.factory((i) => RegisterCubit(i(), i())),

        // Demo service
        AsyncBind<DemoSampleService>((i) async => DemoSampleService().init()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          SplashView.routeName,
          child: (context, args) => BlocProvider(
            create: (context) => Modular.get<SplashCubit>(),
            child: const SplashView(),
          ),
        ),
        ChildRoute(
          SettingsView.routeName,
          child: (context, args) => const SettingsView(),
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
        ),
        ChildRoute(
          HomeView.routeName,
          child: (context, args) => const HomeView(),
        ),
        ChildRoute(
          CategoryView.routeName,
          child: (context, args) => const CategoryView(),
        ),
        ChildRoute(
          VerifyAccountView.routeName + "/:email",
          child: (context, args) => VerifyAccountView(
            email: args.params['email'],
          ),
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
