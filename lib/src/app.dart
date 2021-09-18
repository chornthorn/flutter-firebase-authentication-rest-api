import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/authentication/controller/authentication/authentication_cubit.dart';
import 'features/bottom_navigation/controller/bottom_navigation_cubit.dart';
import 'features/splash/controller/splash_cubit.dart';
import 'features/splash/view/splash_view.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Modular.get<SplashCubit>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<BottomNavigationCubit>()..pageTapped(0,context),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        // theme: ThemeData(),
        // darkTheme: ThemeData.dark(),
        // themeMode: settingsController.themeMode,
        initialRoute: SplashView.routeName,
        builder: EasyLoading.init(),
      ).modular(),
    );
  }
}
