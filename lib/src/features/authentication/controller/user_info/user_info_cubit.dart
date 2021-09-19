import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_fire_auth/src/core/constants.dart';
import 'package:flu_fire_auth/src/features/authentication/model/delete_account_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/email_confirm_code_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/user_info_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/user_info_res_model.dart';
import 'package:flu_fire_auth/src/features/authentication/service/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._service) : super(UserInfoInitial());

  final AuthenticationService _service;

  void getUserInfoOpenApp() async {
    emit(UserInfoLoading());
    try {
      final share = Modular.get<SharedPreferences>();
      final token = share.getString(accessToken);
      if (token != null) {
        final reqModel = UserInfoReqModel(idToken: token);
        final result = await _service.userInfo(reqModel);
        emit(UserInfoLoaded(result.users));
        _service.logged();
      }
    } catch (e) {
      if (e.toString() == "USER_NOT_FOUND") {
        _service.logOut();
      }
      emit(UserInfoInFailure(e.toString()));
    }
  }

  void getUserInfo({
    required String fToken,
    required String aToken,
  }) async {
    EasyLoading.show();
    emit(UserInfoLoading());
    try {
      final share = Modular.get<SharedPreferences>();
      final reqModel = UserInfoReqModel(idToken: aToken);
      final result = await _service.userInfo(reqModel);
      emit(UserInfoLoaded(result.users));
      await share.setString(refreshToken, fToken);
      await share.setString(accessToken, aToken);
      _service.logged();
    } catch (e) {
      emit(UserInfoInFailure(e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  void requestEmailVerify(BuildContext context) async {
    EasyLoading.show();
    emit(UserInfoLoading());
    try {
      final share = Modular.get<SharedPreferences>();
      final token = share.getString(accessToken);
      if (token != null) {
        final reqModel = EmailConfirmCodeReqModel(idToken: token);
        final result = await _service.sendRequestConfirmAccount(reqModel);
        emit(UserConfirmAccountSuccess());
        EasyLoading.dismiss();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'Success',
          desc: 'Verification code has been sent to ${result.email}',
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      emit(UserInfoInFailure(e.toString()));
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        title: 'Error',
        desc: "User account verify unsuccessful",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
      ).show();
    } finally {
      EasyLoading.dismiss();
    }
  }

  void deleteAccount(BuildContext context) async {
    EasyLoading.show();
    emit(UserInfoLoading());
    try {
      final share = Modular.get<SharedPreferences>();
      final token = share.getString(accessToken);
      if (token != null) {
        final reqModel = DeleteAccountReqModel(idToken: token);
        final result = await _service.deleteAccount(reqModel);
        if (result) {
          emit(UserDeleteAccountSuccess());
          EasyLoading.dismiss();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: 'Success',
            desc: 'Account has been remove from system!',
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
          ).show();
          await Future.delayed(const Duration(seconds: 2));
          _service.logOut();
        } else {
          emit(const UserInfoInFailure("User delete unsuccessful"));
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Error',
            desc: "User delete unsuccessful",
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
          ).show();
        }
      }
    } catch (e) {
      emit(UserInfoInFailure(e.toString()));
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        title: 'Error',
        desc: "User delete unsuccessful",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
      ).show();
    } finally {
      EasyLoading.dismiss();
    }
  }
}
