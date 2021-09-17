import 'package:flutter/material.dart';

import 'component/bong_thorn_logo.dart';
import 'component/custom_button.dart';
import 'component/custom_textfield.dart';
import 'component/facebook_button.dart';
import 'component/google_button.dart';
import 'component/or_divider_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = "/login_page";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                const CustomTextField(hint: "Email"),
                const SizedBox(height: 16),
                const CustomTextField(hint: "Password"),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Login',
                  onPressed: () {},
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
    );
  }
}
