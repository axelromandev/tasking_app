import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/presentation/pages/pages.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = Routes.home;

  final pref = SharedPrefs();

  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: Routes.intro,
        builder: (_, __) => const IntroPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: Routes.listTasks,
        builder: (_, state) {
          final listId = int.parse(state.pathParameters['id']!);
          return ListTasksPage(listId);
        },
      ),
      GoRoute(
        path: Routes.settings,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: Routes.about,
        builder: (_, __) => const AboutPage(),
      ),
    ],
    redirect: (context, state) {
      if (pref.getValue<bool>(StorageKeys.isFirstTime) == null) {
        return Routes.intro;
      }
      return null;
    },
  );
});
