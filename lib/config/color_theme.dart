import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorThemeProvider = StateNotifierProvider<_Notifier, Color>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<Color> {
  _Notifier() : super(Colors.blue);
}
