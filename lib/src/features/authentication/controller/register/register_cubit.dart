import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_fire_auth/src/core/constants.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_in_res_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_up_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_up_res_model.dart';
import 'package:flu_fire_auth/src/features/authentication/service/authentication_service.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._service) : super(RegisterInitial());

  final AuthenticationService _service;

  void onSubmitRegister(
      BuildContext context, String email, String password) async {
    emit(RegisterLoading());
    EasyLoading.show();
    try {
      final share = Modular.get<SharedPreferences>();
      if (email.isNotEmpty && password.isNotEmpty) {
        final reqModel = SignUpReqModel(email: email, password: password);
        final result = await _service.signup(reqModel);
        emit(RegisterSuccess(result));
        await share.setString(refreshToken, result.refreshToken);
        await share.setString(accessToken, result.idToken);
        _service.logged();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Success',
          desc: 'Register completed',
          btnOkOnPress: () {
            Modular.to.navigate(MainView.routeName);
          },
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error',
          desc: "Please enter required field!",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
        emit(const RegisterFailure("Please enter required field!"));
      }
    } catch (e) {
      if (e.toString() == "INVALID_PASSWORD") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error',
          desc: "Password are invalid!",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
        emit(const RegisterFailure("Password are invalid!"));
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error',
          desc: e.toString(),
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
        emit(RegisterFailure(e.toString()));
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  void onSubmitLogin(
      BuildContext context, String email, String password) async {
    emit(RegisterLoading());
    EasyLoading.show();
    try {
      final share = Modular.get<SharedPreferences>();
      if (email.isNotEmpty && password.isNotEmpty) {
        final reqModel = SignUpReqModel(email: email, password: password);
        final result = await _service.login(reqModel);
        emit(LoginSuccess(result));
        await share.setString(refreshToken, result.refreshToken);
        await share.setString(accessToken, result.idToken);
        _service.logged();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Success',
          desc: 'Login completed',
          btnOkOnPress: () {
            Modular.to.navigate(MainView.routeName);
          },
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error',
          desc: "Please enter required field!",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
        emit(const RegisterFailure("Please enter required field!"));
      }
    } catch (e) {
      if (e.toString() == "INVALID_PASSWORD") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error',
          desc: "Password are invalid!",
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
        emit(const RegisterFailure("Password are invalid!"));
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Error',
          desc: e.toString(),
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
        emit(RegisterFailure(e.toString()));
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
