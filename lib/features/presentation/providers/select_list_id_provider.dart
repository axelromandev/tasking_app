import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

final selectListIdProvider = StateNotifierProvider<_Notifier, int>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<int> {
  _Notifier() : super(0) {
    _load();
  }

  final _prefs = SharedPrefs();

  Future<void> _load() async {
    final listId = _prefs.getValue<int>(Keys.showCurrentListTasks);
    state = listId ?? 0;
  }

  void change(int listId) {
    _prefs.setKeyValue<int>(Keys.showCurrentListTasks, listId);
    state = listId;
  }
}
