import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.lightGreen[400],
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Hàm hiển thị thông báo lỗi
void showErrorMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red[400],
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
