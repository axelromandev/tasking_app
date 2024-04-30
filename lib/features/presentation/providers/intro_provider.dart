import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final introProvider = Provider.autoDispose((ref) {
  // final prefs = SharedPrefs();
  // final isarService = IsarService();

  Future<void> finish(BuildContext context) async {
    try {
      // await prefs.setKeyValue<bool>(Keys.isFirstTime, true);
      // await isarService.tutorial();
    } catch (e) {
      print(e);
    }
  }

  return finish;
});
