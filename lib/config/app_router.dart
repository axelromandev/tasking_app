import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/app.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = HomePage.routePath;

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
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
        path: SettingsPage.routePath,
        builder: (_, __) => const SettingsPage(),
      )
    ],
  );
});
