import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/app.dart';
import '../const/constants.dart';

final navigatorGlobalKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = HomePage.routePath;

  final pref = SharedPrefs();

  return GoRouter(
    initialLocation: initialLocation,
    navigatorKey: navigatorGlobalKey,
    routes: [
      GoRoute(
        path: IntroPage.routePath,
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
        path: HomePage.routePath,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: ListTasksPage.routePath,
        builder: (_, state) {
          final listId = int.parse(state.pathParameters['id']!);
          return ListTasksPage(listId);
        },
      ),
      GoRoute(
        path: SettingsPage.routePath,
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
