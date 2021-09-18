import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/register/register_cubit.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_list_view.dart';
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String routeName = "/sign_up_page";

  static Page page() => const MaterialPage<void>(child: SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        if (state is RegisterSuccess) {
          EasyLoading.dismiss();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.SCALE,
            title: 'Success',
            desc: 'Register completed',
            btnOkOnPress: () {
              Modular.to.navigate(SampleItemListView.routeName);
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
                  SizedBox(height: size.height * 0.03),
                  const BongThornLogo(),
                  const SizedBox(height: 60),
                  const CustomTextField(hint: "Full name"),
                  const SizedBox(height: 16),
                  CustomTextField(hint: "Email", controller: email),
                  const SizedBox(height: 16),
                  CustomTextField(hint: "Password", controller: password),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      Modular.get<RegisterCubit>()
                          .onSubmitRegister(context,email.text, password.text);
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  const ORDivider(),
                  const SizedBox(height: 16),
                  FacebookButton(
                    label: 'Sign Up with Facebook',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  GoogleButton(
                    label: 'Sign Up with Google',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 24),
                  const Text.rich(
                    TextSpan(
                      text: 'By signing up you accept the',
                      children: [
                        TextSpan(
                          text: ' Terms of Service ',
                          style: TextStyle(color: Color(0xff4e7ab6)),
                        ),
                        TextSpan(text: 'and'),
                        TextSpan(
                          text: ' Privacy Policy ',
                          style: TextStyle(color: Color(0xff4e7ab6)),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      const Text(
                        " Login",
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
