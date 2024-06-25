// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import 'list_tasks_provider.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, Task, Task>((ref, task) {
  final refreshList = ref.read(listTasksProvider.notifier).refresh;

  return _Notifier(task: task, refreshList: refreshList);
});

class _Notifier extends StateNotifier<Task> {
  _Notifier({
    required Task task,
    required this.refreshList,
  }) : super(task) {
    noteController = TextEditingController(text: task.note);
    final subtasks = task.subtasks.toList();
    subtasksControllers = List.generate(
      subtasks.length,
      (i) => {subtasks[i].id: TextEditingController(text: subtasks[i].message)},
    );
  }

  final Future<void> Function() refreshList;

  final _taskRepository = TaskRepository();
  final _subtasksRepository = SubtasksRepository();
  final _debouncer = Debouncer();

  final subtaskAddController = TextEditingController();

  late TextEditingController noteController;
  late List<Map<int, TextEditingController>> subtasksControllers;

  Future<void> _refresh() async {
    final task = await _taskRepository.get(state.id);
    state = task;
  }

  Future<void> onToggleCompletedStatus() async {
    state.completed = !state.completed;
    await _taskRepository.update(state);
    refreshList();
  }

  Future<void> onDeleteTask() async {
    await _taskRepository.delete(state.id).then((_) {
      refreshList();
    });
  }

  Future<void> onDeleteCompleted() async {
    if (!state.completed) return;
    await _taskRepository.delete(state.id);
    refreshList();
  }

  void onMessageChanged(String value) {
    _debouncer.run(() async {
      final String name = value.trim();
      if (name.isEmpty) return;
      if (state.message == name) return;
      state.message = value;
      await _taskRepository.update(state);
      refreshList();
    });
  }

  void onNoteChanged(String value) {
    _debouncer.run(() async {
      final String note = value.trim();
      if (note.isEmpty) return;
      if (state.note == note) return;
      state.note = value;
      await _taskRepository.update(state);
      refreshList();
    });
  }

  Future<void> onNoteDeleted() async {
    state.note = null;
    noteController.clear();
    await _taskRepository.update(state);
    refreshList();
  }

  Future<void> onSubtaskAdd(String value) async {
    final String name = value.trim();
    if (name.isEmpty) return;
    subtaskAddController.clear();
    await _subtasksRepository.add(state.id, name);
    _refresh();
    refreshList();
  }

  void onSubtaskToggleCompleted(SubTask subtask) {
    subtask.completed = !subtask.completed;
    _subtasksRepository.update(subtask);
    _refresh();
    refreshList();
  }

  Future<void> onSubtaskDelete(SubTask subtask) async {
    await _subtasksRepository.delete(subtask.id);
    _refresh();
    refreshList();
  }

  Future<void> onListTasksChanged(int newListTaskId) async {
    await _taskRepository.changeList(state.id, newListTaskId);
    refreshList();
  }
}
