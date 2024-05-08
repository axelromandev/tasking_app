import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, Task>((ref, task) {
  return _Notifier(task);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(Task task) : super(_State(task: task));

  final _taskRepository = TaskRepository();

  Future<void> onToggleCompleted() async {
    final task = state.task;
    final newTask = task.copyWith(completed: !task.completed);
    await _taskRepository.update(newTask);
    state = state.copyWith(task: newTask);
  }
}

class _State {
  final Task task;

  _State({required this.task});

  _State copyWith({
    Task? task,
  }) {
    return _State(
      task: task ?? this.task,
    );
  }
}
