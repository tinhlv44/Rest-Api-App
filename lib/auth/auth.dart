import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_app/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:rest_api_app/screens/login.dart';
import 'package:rest_api_app/screens/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginScreen(show: go),
      );
    } else {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: SignUPScreen(show: go),
      );
    }
  }
}
