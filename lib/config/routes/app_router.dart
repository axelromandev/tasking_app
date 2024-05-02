import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../const/constants.dart';
import 'routes.dart';

final navigatorGlobalKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = Routes.home.path;

  final pref = SharedPrefs();

  return GoRouter(
    initialLocation: initialLocation,
    navigatorKey: navigatorGlobalKey,
    routes: [
      Routes.intro,
      Routes.home,
      Routes.settings,
      Routes.notifications,
      Routes.language,
    ],
    redirect: (context, state) {
      if (pref.getValue<bool>(Keys.isFirstTime) == null) {
        return Routes.intro.path;
      }
      return null;
    },
  );
});
