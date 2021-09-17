import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_fire_auth/src/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    registerService();
  }

  void registerService() async {
    _initEasyOverlay();
    try {
      await sl.allReady();
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
