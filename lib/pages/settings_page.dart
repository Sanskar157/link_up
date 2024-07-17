import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/auth/login_or_register.dart';
import 'package:chatapp/pages/blocked_users_page.dart';
import 'package:chatapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext context) {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                color: Theme.of(context).colorScheme.tertiary,
                child: ListTile(
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 101, 91),
                      fontSize: 18,
                    ),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 240, 101, 91),
                    size: 35,
                  ),
                  onTap: () {
                    logout(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginOrRegister(),
                    ));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                color: Theme.of(context).colorScheme.tertiary,
                child: ListTile(
                  title: Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.moon,
                    size: 30,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                color: Theme.of(context).colorScheme.tertiary,
                child: ListTile(
                  title: Text(
                    "Blocked Users",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.userSlash,
                    size: 30,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlockedUsersPage(),
                    ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
