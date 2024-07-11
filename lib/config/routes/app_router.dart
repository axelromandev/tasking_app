import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/app.dart';
import '../const/constants.dart';
import 'routes.dart';

final navigatorGlobalKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = Routes.home;

  final pref = SharedPrefs();

  return GoRouter(
    initialLocation: initialLocation,
    navigatorKey: navigatorGlobalKey,
    routes: [
      GoRoute(
        path: Routes.intro,
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: Routes.listTasks,
        builder: (_, state) {
          final listId = int.parse(state.pathParameters['id']!);
          return ListTasksPage(listId);
        },
      ),
      GoRoute(
        path: Routes.settings,
        builder: (_, __) => const SettingsPage(),
      ),
    ],
    redirect: (context, state) {
      if (pref.getValue<bool>(Keys.isFirstTime) == null) {
        return IntroPage.routePath;
      }
      return null;
    },
  );
});
