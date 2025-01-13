import 'package:flutter/material.dart';
import 'package:rest_api_app/auth/auth.dart';
import 'package:rest_api_app/util/auth_manager.dart';
import 'package:rest_api_app/util/mode.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              ModeAppManager.isDarkMode() ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Switch(
              value: ModeAppManager.isDarkMode(),
              onChanged: (bool value) {
                setState(() {
                  ModeAppManager.setDarkMode(value);
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          AuthManager.logout();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AuthPage(),
          ));
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(0, 82, 80, 80),
                const Color.fromARGB(255, 197, 238, 198),
              ],
              tileMode: TileMode.clamp,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.logout,
            color: Colors.green.shade600,
            size: 40,
          ),
        ),
      ),
    );
  }
}
