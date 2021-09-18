import 'dart:async';
import 'dart:convert';
import 'package:flu_fire_auth/src/core/constants.dart';
import 'package:flu_fire_auth/src/features/authentication/model/sign_in_res_model.dart';
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
  }

  void logged() {
    return _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    final share = Modular.get<SharedPreferences>();
    await share.remove(refreshToken);
    await share.remove(accessToken);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<String?> getAccessToken() async {
    try {
      final sp = await SharedPreferences.getInstance();
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
      final url = Uri.parse(baseUrl + "/accounts:signInWithPassword?key=$apiKey");
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
}
