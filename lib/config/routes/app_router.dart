import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/app/presentation/pages/language_page.dart';
import 'package:tasking/config/const/constants.dart';
import 'package:tasking/config/routes/routes_path.dart';
import 'package:tasking/core/core.dart';

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
      if (pref.getValue<bool>(Keys.isFirstTime) == null) {
        return RoutesPath.intro;
      }
      return null;
    },
  );
});
