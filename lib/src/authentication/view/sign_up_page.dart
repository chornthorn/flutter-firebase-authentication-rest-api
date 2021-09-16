import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:lottie/lottie.dart';
import 'welcome_page.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String routeName = "/sign_up_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 70),
                  ClipOval(
                    child: Container(
                      width: 120,
                      height: 120,
                      color: Colors.blue,
                      child: Lottie.asset('assets/lotties/flutter_logo.json'),
                    ),
                  ),
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
                  const SizedBox(height: 35),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 0.4,
                            width: double.maxFinite,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "or",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 0.4,
                            width: double.maxFinite,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration:
                                  const BoxDecoration(color: Color(0xff3A5285)),
                              child: const Icon(FontAwesome.facebook,
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color(0xff4A6EA8),
                              ),
                              child: const Text(
                                "Sign Up with Facebook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 1.2,
                                      color: Colors.grey.withOpacity(0.4)),
                                  top: BorderSide(
                                      width: 1.2,
                                      color: Colors.grey.withOpacity(0.4)),
                                  bottom: BorderSide(
                                      width: 1.2,
                                      color: Colors.grey.withOpacity(0.4)),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  'assets/icons/google_icon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.4),
                                    width: 1.2),
                              ),
                              child: Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: const Text.rich(
                      TextSpan(
                        text: 'By signing up you accept the',
                        // default text style
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
                  ),
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:   [
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, this.controller, this.hint})
      : super(key: key);

  final TextEditingController? controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: const BoxDecoration(
        color: Color(0xfff0f5fc),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
