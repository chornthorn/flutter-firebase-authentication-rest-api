import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/register/register_cubit.dart';
import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          EasyLoading.show();
        }
        if (state is RegisterFailure) {
          EasyLoading.dismiss();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Error',
            desc: state.message,
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
          ).show();
        }
        if (state is LoginSuccess) {
          EasyLoading.dismiss();
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
        }
      },
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
                    CustomTextField(hint: "Email",controller: email),
                  const SizedBox(height: 16),
                    CustomTextField(hint: "Password",controller: password),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      Modular.get<RegisterCubit>()
                          .onSubmitLogin(context,email.text, password.text);
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
                      const Text(
                        " Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
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
