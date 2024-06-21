import 'package:go_router/go_router.dart';

import '../../features/app.dart';

class Routes {
  static GoRoute intro = GoRoute(
    path: '/intro',
    builder: (context, state) => const IntroPage(),
  );

  static GoRoute home = GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  );

  static GoRoute task = GoRoute(
    path: '/task',
    builder: (context, state) {
      final task = state.extra! as Task;
      return TaskPage(task);
    },
  );

  static GoRoute settings = GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsPage(),
  );

  static GoRoute language = GoRoute(
    path: '/settings/language',
    builder: (context, state) => const LanguagePage(),
  );
}
