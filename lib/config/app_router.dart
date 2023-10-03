import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/presentation.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = HomePage.routePath;

  return GoRouter(
    initialLocation: initialLocation,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: HomePage.routePath,
        builder: (_, __) => const HomePage(),
      )
    ],
  );
});
