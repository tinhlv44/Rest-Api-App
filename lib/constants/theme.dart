import 'package:flutter/material.dart';

class AppTheme {
  // Phương thức tạo ThemeData chính
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 189, 255, 175),
      foregroundColor: Color.fromARGB(255, 0, 0, 0),
      elevation: 4,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.blue, // Màu nền của BottomNavigationBar
      selectedItemColor: Colors.white, // Màu của mục được chọn
      unselectedItemColor: Colors.grey, // Màu của mục không được chọn
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
