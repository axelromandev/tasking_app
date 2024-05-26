import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

final introProvider = Provider.autoDispose((ref) {
  final prefs = SharedPrefs();
  final isarService = IsarService();

  Future<void> finish(BuildContext context) async {
    try {
      await isarService.tutorial().then((status) {
        if (status) {
          prefs.setKeyValue<bool>(Keys.isFirstTime, true);
          prefs.setKeyValue<int>(Keys.showCurrentListTasks, 1);
          context.go(Routes.home.path);
        }
      });
    } catch (e) {
      log('$e', name: 'IntroProvider');
    }
  }

  return finish;
});
