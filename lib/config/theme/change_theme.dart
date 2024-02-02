import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routes/app_router.dart';

final changeThemeProvider = StateNotifierProvider<_Notifier, bool>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<bool> {
  _Notifier() : super(true) {
    // initialize();
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
