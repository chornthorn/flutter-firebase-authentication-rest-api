import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/user_info/user_info_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/view/component/bong_thorn_logo.dart';
import 'package:flu_fire_auth/src/features/authentication/view/verify_account_view.dart';
import 'package:flu_fire_auth/src/features/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flu_fire_auth/src/features/splash/controller/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const String routeName = "/";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashCubit>().registerService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              Modular.to.navigate(WelcomePage.routeName);
            }
          },
        ),
        BlocListener<UserInfoCubit, UserInfoState>(
          listener: (context, state) {
            if (state is UserInfoLoaded) {
              if (state.data[0].emailVerified) {
                Modular.to.navigate(MainView.routeName);
              } else {
                Modular.to.navigate(
                  VerifyAccountView.routeName + "/" + state.data[0].email,
                );
              }
            }
          },
        ),
      ],
      child: const SplashScreen(),
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
