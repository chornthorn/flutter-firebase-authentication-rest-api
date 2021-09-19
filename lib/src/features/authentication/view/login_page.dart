import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/register/register_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/user_info/user_info_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/view/sign_up_page.dart';
import 'package:flu_fire_auth/src/features/authentication/view/verify_account_view.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'component/bong_thorn_logo.dart';
import 'component/custom_button.dart';
import 'component/custom_textfield.dart';
import 'component/facebook_button.dart';
import 'component/google_button.dart';
import 'component/or_divider_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = "/login_page";

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<UserInfoCubit, UserInfoState>(
          listener: (context, state) {
            if (state is UserInfoLoaded) {
              if (state.data[0].emailVerified) {
                Modular.to.navigate(MainView.routeName);
              } else {
                Modular.to.navigate(
                  VerifyAccountView.routeName + "/" + state.data[0].email,
                );
              }
            }
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              Modular.to.navigate(MainView.routeName);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 35),
            alignment: Alignment.center,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: size.height * 0.12),
                  const BongThornLogo(),
                  const SizedBox(height: 60),
                  CustomTextField(hint: "Email", controller: email),
                  const SizedBox(height: 16),
                  CustomTextField(hint: "Password", controller: password),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      Modular.get<RegisterCubit>()
                          .onSubmitLogin(context, email.text, password.text);
                    },
                  ),
                  const SizedBox(height: 35),
                  const ORDivider(),
                  const SizedBox(height: 16),
                  FacebookButton(
                    label: 'Login with Facebook',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  GoogleButton(
                    label: 'Login with Google',
                    onPressed: () {},
                  ),
                  SizedBox(height: size.height * .06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Modular.to.pushNamed(SignUpPage.routeName);
                        },
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
