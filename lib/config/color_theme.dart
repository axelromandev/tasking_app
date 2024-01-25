import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/core.dart';
import 'config.dart';

final colorThemeProvider = StateNotifierProvider<_Notifier, Color>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<Color> {
  _Notifier() : super(Colors.indigo) {
    initialize();
  }

  final _pref = SharedPrefsService();

  final controller = ExpansionTileController();

  void initialize() {
    final colorValue = _pref.getValue<int>(Keys.colorSeed);
    if (colorValue == null) return;
    state = Color(colorValue);
  }

  void setColor(Color color) async {
    await _pref.setKeyValue<int>(Keys.colorSeed, color.value);
    state = color;
    controller.collapse();
  }
}
