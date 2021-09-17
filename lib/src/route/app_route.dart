import 'package:animations/animations.dart';
import 'package:flu_fire_auth/src/authentication/view/login_page.dart';
import 'package:flu_fire_auth/src/authentication/view/sign_up_page.dart';
import 'package:flu_fire_auth/src/authentication/view/welcome_page.dart';
import 'package:flu_fire_auth/src/sample_feature/sample_item_details_view.dart';
import 'package:flu_fire_auth/src/sample_feature/sample_item_list_view.dart';
import 'package:flu_fire_auth/src/settings/settings_controller.dart';
import 'package:flu_fire_auth/src/settings/settings_service.dart';
import 'package:flu_fire_auth/src/settings/settings_view.dart';
import 'package:flu_fire_auth/src/splash/view/splash_view.dart';
import 'package:flutter/material.dart';

Route generateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments;

  switch (routeSettings.name) {
    case SplashView.routeName:
      return pageRoute(const SplashView());
    case SettingsView.routeName:
      return pageRoute(
          SettingsView(controller: SettingsController(SettingsService())));
    case SampleItemDetailsView.routeName:
      return pageRoute(const SampleItemDetailsView());
    case SampleItemListView.routeName:
      return pageRoute(const SampleItemListView());
    case SignUpPage.routeName:
      return pageRoute(const SignUpPage());
    case LoginPage.routeName:
      return pageRoute(const LoginPage());
    case WelcomePage.routeName:
    // default:
    //   return pageRoute(const WelcomePage());
  }
  return generateRoute(routeSettings);
}

Route pageRoute(Widget child) {
  return PageRouteBuilder<void>(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled,
        child: child,
      );
    },
  );
}
