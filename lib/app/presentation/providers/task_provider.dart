import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier(ref);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final Ref ref;

  TaskNotifier(this.ref) : super([]) {
    getAll();
  }

  final _taskRepository = TaskRepositoryImpl();

  Future<void> getAll() async {
    final tasks = await _taskRepository.getAll();
    state = tasks;
  }

  void onSubmit(String value) async {
    ref.read(controllerProvider).clear();

    if (value.trim().isEmpty) return;

    final task = Task(
      message: value,
      dueDate: null,
      isCompleted: false,
    );

    await _taskRepository.write(task);

    getAll();
  }

  void onToggleCheck(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _taskRepository.write(task);
    getAll();
  }

  void onShowDetails(BuildContext context, Task task) async {
    FocusScope.of(context).unfocus();
    await showModalBottomSheet(
      context: context,
      elevation: 0,
      builder: (_) => TaskDetails(task),
    );
  }

  Future<void> deleteTask(Task task) async {
    await _taskRepository.delete(task.id);
    getAll();
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.write(task);
    getAll();
  }
}

final controllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
