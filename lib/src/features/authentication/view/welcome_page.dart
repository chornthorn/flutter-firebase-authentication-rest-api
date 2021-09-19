import 'package:flu_fire_auth/src/features/main_view.dart';
import 'package:flu_fire_auth/src/features/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'component/bong_thorn_logo.dart';
import 'component/custom_button.dart';
import 'component/custom_outline_button.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static const String routeName = "/welcome_page";

  static Page page() => const MaterialPage<void>(child: WelcomePage());

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
                SizedBox(height: size.height * 0.09),
                const BongThornLogo(),
                const SizedBox(height: 16),
                const Text(
                  "Bong Thorn",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
                  child: Text(
                    "Discover upcoming events near you",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    Modular.to.pushNamed(SignUpPage.routeName);
                  },
                ),
                const SizedBox(height: 16),
                CustomOutlineButton(
                  label: "Login",
                  onPressed: () {
                    Modular.to.pushNamed(LoginPage.routeName);
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Modular.to.pushNamed(MainView.routeName);
                    },
                    child: const Text(
                      "Go to dashboard",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
