import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/presentation/home/pages/home_page.dart';
import 'package:tasking/features/presentation/intro/intro.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/settings/settings.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final pref = SharedPrefs();

  return GoRouter(
    initialLocation: '/',
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
          return ListTasksView(listId);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsView(),
      ),
      GoRoute(
        path: '/settings/about',
        builder: (_, __) => const AboutPage(),
      ),
      GoRoute(
        path: '/settings/themes',
        builder: (_, __) => const ThemesChangePage(),
      ),
    ],
    redirect: (context, state) {
      if (pref.getValue<bool>(StorageKeys.isFirstTime) == null) {
        return '/intro';
      }
      return null;
    },
  );
});
