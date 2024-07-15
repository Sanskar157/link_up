import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/auth/login_or_register.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext cxt) {
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
                color: Theme.of(context).colorScheme.inversePrimary),
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
          ],
        ));
  }
}
