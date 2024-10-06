import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/providers/providers.dart';

final listTasksProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, ListTasks, int>((ref, listId) {
  final refreshAll = ref.read(listsProvider.notifier).refresh;

  return _Notifier(listId, refreshAll);
});

class _Notifier extends StateNotifier<ListTasks> {
  _Notifier(this.listId, this.refreshAll) : super(ListTasks.empty()) {
    refresh();
  }

  late int listId;
  final Future<void> Function() refreshAll;

  final _tasksRepository = TaskRepositoryImpl();
  final _listTasksRepository = ListTasksRepositoryImpl();

  Future<void> refresh() async {
    try {
      final ListTasks list = await _listTasksRepository.get(listId);
      final tasks = await _tasksRepository.getByListId(list.id);
      list.tasks.addAll(tasks);
      state = list;
    } catch (e) {
      MyToast.show(e.toString());
    }
  }

  void onDelete(BuildContext contextPage) {
    _listTasksRepository.delete(state.id).then((_) {
      refreshAll();
      contextPage.pop();
    });
  }

  Future<void> onMarkIncompleteAllTasks() async {
    final tasks =
        state.tasks.where((task) => task.completedAt != null).toList();
    for (final task in tasks) {
      final newTask = task.toggleCompleted();
      await _tasksRepository.update(newTask);
    }
    refreshAll();
    refresh();
  }

  Future<void> onMarkCompleteAllTasks() async {
    final tasks =
        state.tasks.where((task) => task.completedAt == null).toList();
    for (final task in tasks) {
      final newTask = task.copyWith(
        completedAt: DateTime.now(),
      );
      await _tasksRepository.update(newTask);
    }
    refreshAll();
    refresh();
  }

  Future<void> onDeleteCompletedAllTasks() async {
    final tasks =
        state.tasks.where((task) => task.completedAt != null).toList();
    if (tasks.isEmpty) return;
    for (final task in tasks) {
      await _tasksRepository.delete(task.id);
    }
    refreshAll();
    refresh();
  }
}
