import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_fire_auth/src/core/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading());

  void registerService() async {
    _initEasyOverlay();
    try {
      await Modular.isModuleReady<AppModule>();
      await Future.delayed(const Duration(seconds: 1));
      emit(SplashLoaded());
    } catch (e) {
      emit(SplashFailure(e.toString()));
    }
  }

  void _initEasyOverlay() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..indicatorWidget =
          const CircularProgressIndicator.adaptive(strokeWidth: 2.5)
      ..maskColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..indicatorColor = Colors.blue
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..textColor = Colors.black
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}
