import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';

final listTasksProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, ListTasks?, int>((ref, listId) {
  return _Notifier(listId);
});

class _Notifier extends StateNotifier<ListTasks?> {
  _Notifier(int listId) : super(null) {
    _load(listId);
  }

  final _listTasksRepository = ListTasksRepository();

  Future<void> _load(int listId) async {
    final list = await _listTasksRepository.get(listId);
    state = list;
  }
}
