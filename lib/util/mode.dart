import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Thay đổi chế độ Dark Mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Thông báo cho hệ thống khi trạng thái thay đổi
  }

  // Đặt chế độ Dark Mode cụ thể
  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners(); // Thông báo cập nhật trạng thái
  }
}
