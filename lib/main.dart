import 'package:bloc/bloc.dart';
import 'package:flu_fire_auth/src/dependency_injection.dart' as app_dependency;
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/app_bloc_observer.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register Dependency Injection
  await app_dependency.init();
  Bloc.observer = AppBlocObserver();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
