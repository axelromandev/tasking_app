import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'list_tasks_provider.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, Task, Task>((ref, task) {
  final refreshList = ref.read(listTasksProvider.notifier).refresh;

  return _Notifier(task: task, refreshList: refreshList);
});

class _Notifier extends StateNotifier<Task> {
  final Future<void> Function() refreshList;

  _Notifier({
    required Task task,
    required this.refreshList,
  }) : super(task);

  final _taskRepository = TaskRepository();

  Future<void> onToggleCompletedStatus() async {
    state.completed = !state.completed;
    await _taskRepository.update(state);
    refreshList();
  }

  Future<void> onDeleteCompleted() async {
    if (!state.completed) return;
    await _taskRepository.delete(state.id);
    refreshList();
  }
}
