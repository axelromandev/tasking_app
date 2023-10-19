import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/core.dart';
import 'app_router.dart';

final changeThemeProvider =
    StateNotifierProvider<ChangeThemeNotifier, bool>((ref) {
  return ChangeThemeNotifier();
});

class ChangeThemeNotifier extends StateNotifier<bool> {
  ChangeThemeNotifier() : super(true) {
    getTheme();
  }

  final _prefs = SharedPrefsService();

  Future<void> getTheme() async {
    final isDarkMode = _prefs.getValue<bool>('theme');
    if (isDarkMode == null) {
      await Future.delayed(const Duration(milliseconds: 300), () {
        final context = navigatorKey.currentContext;
        if (context == null) return;
        final brightness = MediaQuery.of(context).platformBrightness;
        state = brightness == Brightness.dark;
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 300), () {
        state = isDarkMode;
      });
    }
  }

  void toggle() async {
    state = !state;
    await _prefs.setKeyValue<bool>('theme', state);
  }
}
