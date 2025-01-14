import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/helpers/snak_bar_helper.dart';
import 'package:rest_api_app/page/auth/auth.dart';
import 'package:rest_api_app/constants/theme.dart';
import 'package:rest_api_app/gitit/gitit.dart';
import 'package:rest_api_app/navi/navi.dart';
import 'package:rest_api_app/util/auth_manager.dart';
import 'package:rest_api_app/util/mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
              scaffoldMessengerKey: snackbarKey,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: AuthManager.isLogedin() ? MyHomeApp() : AuthPage());
        }));
  }
}
