import 'package:flow_builder/flow_builder.dart';
import 'package:flu_fire_auth/src/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/authentication/view/component/bong_thorn_logo.dart';
import 'package:flu_fire_auth/src/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/sample_feature/sample_item_list_view.dart';
import 'package:flu_fire_auth/src/splash/controller/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  static const String routeName = "/";

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
    return FlowBuilder<AuthenticationState>(
      state: context.select((AuthenticationCubit bloc) => bloc.state),
      onGeneratePages: (AuthenticationState state, List<Page> pages) {
        switch (state.status) {
          case AuthenticationStatus.unauthenticated:
            return [WelcomePage.page()];
          case AuthenticationStatus.authenticated:
            return [SampleItemListView.page()];
          case AuthenticationStatus.unknown:
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
