import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../app.dart';

final allListTasksProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _load();
  }

  final _prefs = SharedPrefs();
  final _listTasksRepository = ListTasksRepository();
  final _taskRepository = TaskRepository();

  Future<void> _load() async {
    final lists = await _listTasksRepository.getAll();
    if (lists.isEmpty) return;

    final listsArchived = lists.where((list) => list.archived).toList();
    final listNotArchived = lists.where((list) => !list.archived).toList();

    for (final list in listNotArchived) {
      final tasks = await _taskRepository.getByListId(list.id);
      list.tasks = tasks;
    }

    state = state.copyWith(
      lists: listNotArchived,
      listsArchived: listsArchived,
    );
  }

  Future<void> refreshAll() async {
    await _load();
  }

  void onShowListTasks() {
    _prefs.removeKey(Keys.showCurrentListTasks);
    state = state.reset();
  }
}

class _State {
  _State({
    this.lists = const [],
    this.listsArchived = const [],
  });

  final List<ListTasks> lists;
  final List<ListTasks> listsArchived;

  _State copyWith({
    List<ListTasks>? lists,
    List<ListTasks>? listsArchived,
  }) {
    return _State(
      lists: lists ?? this.lists,
      listsArchived: listsArchived ?? this.listsArchived,
    );
  }

  _State reset() {
    return _State(lists: lists);
  }
}
