import 'package:flutter/material.dart';

class SnackBarHelper {
  // Hàm hiển thị thông báo thành công
  static void showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.lightGreen[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Hàm hiển thị thông báo lỗi
  static void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
