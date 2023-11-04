import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/app.dart';
import '../core/core.dart';
import 'config.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = RoutesPath.home;

  final pref = SharedPrefsService();

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: RoutesPath.intro,
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
        path: RoutesPath.home,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: RoutesPath.task,
        builder: (_, state) {
          String str = state.pathParameters['id'] ?? '999';
          final id = int.parse(str);
          ref.read(taskProvider.notifier).initialize(id);
          return const TaskPage();
        },
      ),
      GoRoute(
        path: RoutesPath.settings,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: RoutesPath.about,
        builder: (_, __) => const AboutPage(),
      )
    ],
    redirect: (context, state) {
      if (pref.getValue<bool>(isFirstTimeKey) == null) {
        return RoutesPath.intro;
      }
      return null;
    },
  );
});
