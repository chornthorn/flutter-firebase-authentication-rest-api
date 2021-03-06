import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flu_fire_auth/src/core/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/app.dart';
import 'src/app_bloc_observer.dart';

EventBus eventBus = EventBus();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
