import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app.dart';

class Routes {
  static RoutePage intro = RoutePage(
    routePath: '/intro',
    page: const IntroPage(),
  );

  static RoutePage home = RoutePage(
    routePath: '/',
    page: const HomePage(),
  );

  static RoutePage settings = RoutePage(
    routePath: '/settings',
    page: const SettingsPage(),
  );

  static RoutePage notifications = RoutePage(
    routePath: '/settings/notifications',
    page: const NotificationsPage(),
  );

  static RoutePage language = RoutePage(
    routePath: '/settings/language',
    page: const LanguagePage(),
  );

  static RoutePage about = RoutePage(
    routePath: '/settings/about',
    page: const AboutPage(),
  );
}

// ---------------------------------------------------------

class RoutePage extends GoRoute {
  final String _routePath;

  @override
  String get path => _routePath;

  RoutePage({
    required String routePath,
    required Widget page,
  })  : _routePath = routePath,
        super(
          path: routePath,
          builder: (_, __) => page,
        );
}
