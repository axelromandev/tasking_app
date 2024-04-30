import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';

final showListTasksProvider =
    StateNotifierProvider.autoDispose<_Notifier, List<ListTasks>>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<List<ListTasks>> {
  _Notifier() : super(const []) {
    _load();
  }

  final listTasksRepository = ListTasksRepository();

  Future<void> _load() async {
    final lists = await listTasksRepository.fetchAll();
    lists.sort((a, b) => a.position.compareTo(b.position));
    state = lists;
  }
}
