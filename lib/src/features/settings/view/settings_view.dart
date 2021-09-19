import 'package:flu_fire_auth/src/features/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/features/authentication/model/authentication_status_model.dart';
import 'package:flu_fire_auth/src/features/authentication/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  static const String routeName = "/settings_view";

  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.unauthenticated) {
          Modular.to.navigate(LoginPage.routeName);
        }
      },
      child: Scaffold(
        body: buildSettingsList(),
      ),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: const Icon(Icons.language),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const LanguagesScreen(),
                ));
              },
            ),
            const SettingsTile(
              title: 'Environment',
              subtitle: 'Production',
              leading: Icon(Icons.cloud_queue),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ],
        ),
        SettingsSection(
          title: 'Account',
          tiles: [
            const SettingsTile(
              title: 'Phone number',
              leading: Icon(Icons.phone),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            const SettingsTile(
              title: 'Email',
              leading: Icon(Icons.email),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            SettingsTile(
              title: 'Sign out',
              leading: const Icon(Icons.exit_to_app),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                print("Sign out");
                context.read<AuthenticationCubit>().logoutRequested();
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Security',
          tiles: [
            SettingsTile.switchTile(
              title: 'Lock app in background',
              leading: const Icon(Icons.phonelink_lock),
              switchValue: lockInBackground,
              onToggle: (bool value) {
                setState(() {
                  lockInBackground = value;
                  notificationsEnabled = value;
                });
              },
            ),
            SettingsTile.switchTile(
              title: 'Use fingerprint',
              subtitle: 'Allow application to access stored fingerprint IDs.',
              leading: const Icon(Icons.fingerprint),
              onToggle: (bool value) {},
              switchValue: false,
            ),
            SettingsTile.switchTile(
              title: 'Change password',
              leading: const Icon(Icons.lock),
              switchValue: true,
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
              title: 'Enable Notifications',
              enabled: notificationsEnabled,
              leading: const Icon(Icons.notifications_active),
              switchValue: true,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Misc',
          tiles: const [
            SettingsTile(
              title: 'Terms of Service',
              leading: Icon(Icons.description),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
            SettingsTile(
              title: 'Open source licenses',
              leading: Icon(Icons.collections_bookmark),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 8),
                child: Image.network(
                  'https://raw.githubusercontent.com/yako-dev/flutter-settings-ui/master/example/assets/settings.png',
                  height: 50,
                  width: 50,
                  color: const Color(0xFF777777),
                ),
              ),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Languages')),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "English",
              trailing: trailingWidget(0),
              onPressed: (BuildContext context) {
                changeLanguage(0);
              },
            ),
            SettingsTile(
              title: "Spanish",
              trailing: trailingWidget(1),
              onPressed: (BuildContext context) {
                changeLanguage(1);
              },
            ),
            SettingsTile(
              title: "Chinese",
              trailing: trailingWidget(2),
              onPressed: (BuildContext context) {
                changeLanguage(2);
              },
            ),
            SettingsTile(
              title: "German",
              trailing: trailingWidget(3),
              onPressed: (BuildContext context) {
                changeLanguage(3);
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeLanguage(int index) {
    setState(() {
      languageIndex = index;
    });
  }
}
