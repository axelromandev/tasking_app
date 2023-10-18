import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/app.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = HomePage.routePath;

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
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
        path: TaskPage.routePath,
        builder: (_, state) {
          String str = state.pathParameters['id'] ?? '999';
          final id = int.parse(str);
          ref.read(taskProvider.notifier).initialize(id);
          return const TaskPage();
        },
      ),
      GoRoute(
        path: SettingsPage.routePath,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: AboutPage.routePath,
        builder: (_, __) => const AboutPage(),
      )
    ],
  );
});
