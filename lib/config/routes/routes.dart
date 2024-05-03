import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/app.dart';

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

  static RoutePage language = RoutePage(
    routePath: '/settings/language',
    page: const LanguagePage(),
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
