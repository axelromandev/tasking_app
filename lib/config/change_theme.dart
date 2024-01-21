import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

final changeThemeProvider =
    StateNotifierProvider<ChangeThemeNotifier, bool>((ref) {
  return ChangeThemeNotifier();
});

class ChangeThemeNotifier extends StateNotifier<bool> {
  ChangeThemeNotifier() : super(false) {
    initialize();
  }

  void initialize() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final brightness = MediaQuery.of(context).platformBrightness;
      state = brightness == Brightness.dark;
    });
  }
}
