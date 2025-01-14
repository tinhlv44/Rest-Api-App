import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/page/auth/auth.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Switch(
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setTheme(value);
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
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
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
