import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import 'select_list_id_provider.dart';

final listTasksProvider =
    StateNotifierProvider.autoDispose<_Notifier, ListTasks?>((ref) {
  final listId = ref.watch(selectListIdProvider);

  return _Notifier(listId);
});

class _Notifier extends StateNotifier<ListTasks?> {
  _Notifier(this.listId) : super(null) {
    _load(listId);
  }

  final int listId;

  final _listTasksRepository = ListTasksRepository();
  final _taskRepository = TaskRepository();

  Future<void> _load(int listId) async {
    final list = await _listTasksRepository.get(listId);
    state = list;
  }

  Future<void> refresh() async {
    await _load(state!.id);
  }

  Future<void> onPinned() async {
    if (state == null) return;
    state!.isPinned = !state!.isPinned;
    await _listTasksRepository.update(state!);
    await _load(state!.id);
  }

  Future<void> onDelete() async {
    if (state == null) return;
    await _listTasksRepository.delete(state!.id);
    state = null;
  }

  Future<void> onMarkIncompleteAllTasks() async {
    if (state == null) return;
    if (state?.tasks == null) return;
    final tasks = state?.tasks.where((task) => task.completed).toList();
    for (final task in tasks!) {
      task.completed = false;
      await _taskRepository.update(task);
    }
    await refresh();
  }

  Future<void> onMarkCompleteAllTasks() async {
    if (state == null) return;
    if (state?.tasks == null) return;
    final tasks = state?.tasks.where((task) => !task.completed).toList();
    for (final task in tasks!) {
      task.completed = true;
      await _taskRepository.update(task);
    }
    await refresh();
  }

  Future<void> onDeleteCompletedAllTasks() async {
    if (state == null) return;
    if (state?.tasks == null) return;
    final tasks = state?.tasks.where((task) => task.completed).toList();
    for (final task in tasks!) {
      await _taskRepository.delete(task.id);
    }
    await refresh();
  }
}
