import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest_api_app/gitit/gitit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkModeProvider = StateProvider<bool>((ref) => false);

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(false);

  void toggleDarkMode() {
    state = !state; // Đổi trạng thái
  }
}

final darkModeNotifierProvider =
    StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});

class ModeAppManager {
  static final SharedPreferences _sharedPref = locator.get();
  static bool isDarkMode() {
    return _sharedPref.getBool('darkmode') ?? false;
  }

  static void setDarkMode(bool value) {
    _sharedPref.setBool('darkmode', value);
  }
}
