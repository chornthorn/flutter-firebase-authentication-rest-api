import 'dart:async';
import 'dart:convert';
import 'package:flu_fire_auth/src/core/constants.dart';
import 'package:flu_fire_auth/src/features/authentication/model/delete_account_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/email_confirm_code_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/email_confirm_code_res_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_in_res_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/user_info_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/user_info_res_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_up_req_model.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_up_res_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield* _checkToken();
  }

  Stream<AuthenticationStatus> _checkToken() async* {
    final result = await getAccessToken();
    if (result != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    if (!_controller.hasListener) {
      yield* _controller.stream;
    }
  }

  void logged() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    final share = Modular.get<SharedPreferences>();
    await share.remove(refreshToken);
    await share.remove(accessToken);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<String?> getAccessToken() async {
    try {
      final sp = Modular.get<SharedPreferences>();
      final result = sp.getString(accessToken);
      if (result != null) return result;
      return null;
    } catch (e) {
      return null;
    }
  }

  void dispose() => _controller.close();

  /// ======================================================================
  Future<SignUpResModel> signup(SignUpReqModel reqModel) async {
    try {
      final url = Uri.parse(baseUrl + "/accounts:signUp?key=$apiKey");
      final result = await http.post(
        url,
        body: {
          "email": reqModel.email,
          "password": reqModel.password,
          "returnSecureToken": true.toString()
        },
      );
      Map<String, dynamic> res = json.decode(result.body);
      if (result.statusCode == 200) {
        return SignUpResModel.fromJson(res);
      } else if (result.statusCode == 400) {
        throw res['error']['message'];
      }
      throw res['error']['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<SignInResModel> login(SignUpReqModel reqModel) async {
    try {
      final url =
          Uri.parse(baseUrl + "/accounts:signInWithPassword?key=$apiKey");
      final result = await http.post(
        url,
        body: {
          "email": reqModel.email,
          "password": reqModel.password,
          "returnSecureToken": true.toString()
        },
      );
      Map<String, dynamic> res = json.decode(result.body);
      if (result.statusCode == 200) {
        return SignInResModel.fromJson(res);
      } else if (result.statusCode == 400) {
        throw res['error']['message'];
      }
      throw res['error']['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserInfoResModel> userInfo(UserInfoReqModel reqModel) async {
    try {
      final url = Uri.parse(baseUrl + "/accounts:lookup?key=$apiKey");
      final result = await http.post(
        url,
        body: {"idToken": reqModel.idToken},
      );
      Map<String, dynamic> res = json.decode(result.body);
      if (result.statusCode == 200) {
        return UserInfoResModel.fromJson(res);
      } else if (result.statusCode == 400) {
        throw res['error']['message'];
      }
      throw res['error']['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<EmailConfirmCodeResModel> sendRequestConfirmAccount(
      EmailConfirmCodeReqModel reqModel) async {
    try {
      final url = Uri.parse(baseUrl + "/accounts:sendOobCode?key=$apiKey");
      final result = await http.post(
        url,
        body: {
          "requestType": "VERIFY_EMAIL",
          "idToken": reqModel.idToken,
        },
      );
      Map<String, dynamic> res = json.decode(result.body);
      if (result.statusCode == 200) {
        return EmailConfirmCodeResModel.fromJson(res);
      } else if (result.statusCode == 400) {
        throw res['error']['message'];
      }
      throw res['error']['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteAccount(DeleteAccountReqModel reqModel) async {
    try {
      final url = Uri.parse(baseUrl + "/accounts:delete?key=$apiKey");
      final result = await http.post(
        url,
        body: {"idToken": reqModel.idToken},
      );
      Map<String, dynamic> res = json.decode(result.body);
      if (result.statusCode == 200) {
        return res['kind'] == "identitytoolkit#DeleteAccountResponse";
      } else if (result.statusCode == 400) {
        throw res['error']['message'];
      }
      throw res['error']['message'];
    } catch (e) {
      throw e.toString();
    }
  }
}
