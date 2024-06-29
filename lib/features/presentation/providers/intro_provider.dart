import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../pages/list_tasks_page.dart';
import '../presentation.dart';

final introProvider = Provider.autoDispose((ref) {
  final prefs = SharedPrefs();
  final dbHelper = DatabaseHelper();

  Future<void> finish(BuildContext context) async {
    try {
      await dbHelper.insertTutorialList().then((_) {
        prefs.setKeyValue<bool>(Keys.isFirstTime, true);
        prefs.setKeyValue<int>(Keys.showCurrentListTasks, 1);
        context.go(HomePage.routePath);
        context.push(ListTasksPage.routePath.replaceFirst(':id', '1'));
      });
    } catch (e) {
      log('$e', name: 'IntroProvider');
    }
  }

  return finish;
});
