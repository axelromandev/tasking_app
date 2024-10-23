import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/presentation/lists/lists.dart';

final introProvider = Provider.autoDispose((ref) {
  final prefs = SharedPrefs();
  final dbHelper = DatabaseHelper();

  Future<void> finish(BuildContext context) async {
    try {
      await dbHelper.insertTutorialList().then((_) {
        prefs.setKeyValue<bool>(StorageKeys.isFirstTime, true);
        context.go('/');
        context.push(ListTasksView.routePath.replaceFirst(':id', '2'));
      });
    } catch (e) {
      log('$e', name: 'IntroProvider');
    }
  }

  return finish;
});
