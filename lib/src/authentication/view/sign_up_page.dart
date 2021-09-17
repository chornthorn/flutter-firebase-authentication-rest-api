import 'package:flutter/material.dart';
import 'component/bong_thorn_logo.dart';
import 'component/custom_button.dart';
import 'component/custom_textfield.dart';
import 'component/facebook_button.dart';
import 'component/google_button.dart';
import 'component/or_divider_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String routeName = "/sign_up_page";

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
                SizedBox(height: size.height * 0.03),
                const BongThornLogo(),
                const SizedBox(height: 60),
                const CustomTextField(hint: "Full name"),
                const SizedBox(height: 16),
                const CustomTextField(hint: "Email"),
                const SizedBox(height: 16),
                const CustomTextField(hint: "Password"),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {},
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
    );
  }
}
