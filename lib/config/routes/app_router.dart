import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/presentation/home/pages/home_page.dart';
import 'package:tasking/features/presentation/intro/intro.dart';
import 'package:tasking/features/presentation/search/search.dart';
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
        path: '/tutorial',
        builder: (_, __) => const TutorialPage(),
      ),
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/search',
        builder: (_, __) => const SearchPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsView(),
      ),
      GoRoute(
        path: '/settings/backup',
        builder: (_, __) => const BackupPage(),
      ),
      GoRoute(
        path: '/settings/themes',
        builder: (_, __) => const ThemesChangePage(),
      ),
      GoRoute(
        path: '/settings/language',
        builder: (_, __) => const LanguagePage(),
      ),
      GoRoute(
        path: '/settings/about',
        builder: (_, __) => const AboutPage(),
      ),
    ],
    redirect: (context, state) {
      if (pref.getValue<bool>(StorageKeys.isFirstTime) == null) {
        if (state.matchedLocation == '/tutorial') return null;
        return '/intro';
      }
      return null;
    },
  );
});
