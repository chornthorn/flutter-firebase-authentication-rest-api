import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/controller/user_info/user_info_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'component/bong_thorn_logo.dart';
import 'component/custom_button.dart';
import 'component/custom_outline_button.dart';

class VerifyAccountView extends StatelessWidget {
  const VerifyAccountView({Key? key, required this.email}) : super(key: key);
  final String? email;

  static const String routeName = "/verify_account_view";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        Modular.get<UserInfoCubit>().getUserInfoOpenApp();
      },
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.unauthenticated) {
            Modular.to.navigate(WelcomePage.routeName);
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
                    SizedBox(height: size.height * 0.09),
                    const BongThornLogo(),
                    const SizedBox(height: 16),
                    const Text(
                      "Activation Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 24),
                      child: Text(
                        "Please press resend verification account!",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        Modular.args.params['email'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 120),
                    CustomButton(
                      text: 'Send verification code',
                      onPressed: () {
                        Modular.get<UserInfoCubit>()
                            .requestEmailVerify(context);
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomOutlineButton(
                      label: "This not my email account",
                      textColor: Colors.redAccent,
                      borderColor: Colors.redAccent,
                      onPressed: () {
                        Modular.get<UserInfoCubit>().deleteAccount(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
