import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app.dart';
import '../../app/presentation/pages/intro_setup_page.dart';
import '../../app/presentation/pages/language_page.dart';
import '../../core/core.dart';
import '../const/constants.dart';
import 'routes_path.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = RoutesPath.home;

  final pref = SharedPrefs();

  return GoRouter(
    initialLocation: initialLocation,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: RoutesPath.intro,
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
        path: RoutesPath.introSetup,
        builder: (_, __) => const IntroSetupPage(),
      ),
      GoRoute(
        path: RoutesPath.home,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: RoutesPath.settings,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: RoutesPath.notifications,
        builder: (_, __) => const NotificationsPage(),
      ),
      GoRoute(
        path: RoutesPath.language,
        builder: (_, __) => const LanguagePage(),
      ),
      GoRoute(
        path: RoutesPath.about,
        builder: (_, __) => const AboutPage(),
      )
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath;
      if (pref.getValue<bool>(Keys.isFirstTime) == null) {
        if (isGoingTo == RoutesPath.introSetup) {
          return RoutesPath.introSetup;
        }
        return RoutesPath.intro;
      }
      return null;
    },
  );
});
