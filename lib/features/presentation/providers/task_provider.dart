// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import 'all_list_tasks_provider.dart';
import 'list_tasks_provider.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, Task, Task>((ref, task) {
  final refreshAll = ref.read(allListTasksProvider.notifier).refreshAll;
  final refreshList = ref.read(listTasksProvider(task.listId).notifier).refresh;

  return _Notifier(
    task: task,
    refreshAll: refreshAll,
    refreshList: refreshList,
  );
});

class _Notifier extends StateNotifier<Task> {
  _Notifier({
    required Task task,
    required this.refreshAll,
    required this.refreshList,
  }) : super(task);

  final Future<void> Function() refreshAll;
  final Future<void> Function() refreshList;

  final _taskRepository = TaskRepository();
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  TextEditingController subtaskAddController = TextEditingController();

  Future<void> onDeleteTask() async {
    await _taskRepository.delete(state.id).then((_) {
      refreshAll();
      refreshList();
    });
  }

  void onToggleCompleted() {
    _taskRepository.updateCompleted(state.id, !state.completed).then((_) {
      refreshAll();
      refreshList();
    });
  }

  void onTitleChanged(String value) {
    _debouncer.run(() {
      final String title = value.trim();
      if (title.isEmpty || state.title == title) return;
      _taskRepository.updateTitle(state.id, title).then((_) {
        refreshAll();
        refreshList();
      });
    });
  }

  void onNoteChanged(String value) {
    _debouncer.run(() async {
      final String note = value.trim();
      if (state.note == note) return;
      _taskRepository.updateNote(state.id, note).then((_) {
        refreshAll();
        refreshList();
      });
    });
  }
}
