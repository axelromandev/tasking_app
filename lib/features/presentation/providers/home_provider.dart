import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../generated/strings.g.dart';
import '../pages/all_list_tasks_page.dart';
import '../pages/list_tasks_archived_page.dart';
import '../pages/settings_page.dart';

final homeScaffoldKeyProvider = Provider<GlobalKey<ScaffoldState>>((ref) {
  return GlobalKey<ScaffoldState>();
});

final homeProvider = StateNotifierProvider<_Notifier, int>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<int> {
  _Notifier() : super(0);

  final List<_Page> pages = [
    _Page(
      title: S.pages.home.drawer.tasks,
      icon: BoxIcons.bx_task,
      child: const AllListTasksPage(),
    ),
    _Page(
      title: S.pages.home.drawer.reminders,
      icon: BoxIcons.bx_bell,
      child: const Placeholder(),
    ),
    _Page(
      title: S.pages.home.drawer.archived,
      icon: BoxIcons.bx_archive,
      child: const ListTasksArchivedPage(),
    ),
    _Page(
      title: S.pages.home.drawer.settings,
      icon: BoxIcons.bx_cog,
      child: const SettingsPage(),
    ),
  ];

  // ignore: use_setters_to_change_properties
  void onChangeIndex(int index) {
    state = index;
  }
}

class _Page {
  _Page({
    required this.title,
    required this.icon,
    required this.child,
  });

  String title;
  IconData icon;
  Widget child;
}
