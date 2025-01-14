import 'package:flutter/material.dart';

// GlobalKey quản lý ScaffoldMessenger
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

// Hàm tổng quát hiển thị SnackBar
void showSnackBar({
  required String message,
  required Color backgroundColor,
  Duration duration = const Duration(seconds: 3),
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white), // Định dạng chữ
    ),
    backgroundColor: backgroundColor,
    duration: duration,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}

// Hàm hiển thị thông báo thành công
void showSuccessMessage(
    {required String message, Duration duration = const Duration(seconds: 3)}) {
  showSnackBar(
    message: message,
    backgroundColor: Colors.lightGreen[400]!,
    duration: duration,
  );
}

// Hàm hiển thị thông báo lỗi
void showErrorMessage(
    {required String message, Duration duration = const Duration(seconds: 3)}) {
  showSnackBar(
    message: message,
    backgroundColor: Colors.red[400]!,
    duration: duration,
  );
}
