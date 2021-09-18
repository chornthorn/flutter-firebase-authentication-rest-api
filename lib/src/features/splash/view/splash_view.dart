import 'package:flow_builder/flow_builder.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/view/component/bong_thorn_logo.dart';
import 'package:flu_fire_auth/src/features/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flu_fire_auth/src/features/splash/controller/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: Modular.get<SplashCubit>(),
      builder: (context, state) {
        if (state is SplashLoaded) {
          return const CheckAuthentication();
        } else if (state is SplashFailure) {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );
        }
        return const SplashScreen();
      },
    );
  }
}

class CheckAuthentication extends StatelessWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationState>(
      state: context.select((AuthenticationCubit bloc) => bloc.state),
      onGeneratePages: (AuthenticationState state, List<Page> pages) {
        switch (state.status) {
          case AuthenticationStatus.unauthenticated:
            return [WelcomePage.page()];
          case AuthenticationStatus.authenticated:
            return [MainView.page()];
          case AuthenticationStatus.loading:
          default:
            return [SplashScreen.page()];
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SplashScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            BongThornLogo(),
          ],
        ),
      ),
    );
  }
}
