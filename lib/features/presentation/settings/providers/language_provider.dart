import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';

final languageProvider = StateNotifierProvider<_Notifier, Locale?>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<Locale?> {
  _Notifier() : super(null) {
    _initialize();
  }

  final _prefs = SharedPrefs();

  void _initialize() {
    final locale = _prefs.getValue<String>('locale');
    if (locale != null) {
      state = Locale(locale);
    }
  }

  void setLocale(String locale) {
    _prefs.setKeyValue<String>('locale', locale).then((_) {
      state = Locale(locale);
    });
  }
}
