import 'package:flutter_riverpod/flutter_riverpod.dart';

final changeThemeProvider =
    StateNotifierProvider<ChangeThemeNotifier, bool>((ref) {
  return ChangeThemeNotifier();
});

class ChangeThemeNotifier extends StateNotifier<bool> {
  ChangeThemeNotifier() : super(true);

  void toggle() {
    state = !state;
  }

  void setTheme(bool isDarkMode) {
    state = isDarkMode;
  }
}
