import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/app.dart';
import '../../features/presentation/pages/list_tasks_page.dart';
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
        path: '/intro',
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/list/:id',
        builder: (_, state) {
          final listId = int.parse(state.pathParameters['id']!);
          return ListTasksPage(listId);
        },
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
