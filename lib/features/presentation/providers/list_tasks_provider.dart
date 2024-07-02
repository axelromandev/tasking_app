import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/domain.dart';
import 'all_list_tasks_provider.dart';

final listTasksProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, ListTasks, int>((ref, listId) {
  final refreshAll = ref.read(allListTasksProvider.notifier).refreshAll;

  return _Notifier(listId, refreshAll);
});

class _Notifier extends StateNotifier<ListTasks> {
  _Notifier(this.listId, this.refreshAll) : super(ListTasks.empty()) {
    refresh();
  }

  late int listId;
  final Future<void> Function() refreshAll;

  final _tasksRepository = TaskRepository();
  final _listTasksRepository = ListTasksRepository();

  Future<void> refresh() async {
    _listTasksRepository.get(listId).then((value) {
      final list = value!;
      _tasksRepository.getByListId(list.id).then((tasks) {
        list.tasks = tasks;
      });
      super.state = list;
    });
  }

  void onPinned() {
    _listTasksRepository.updatePinned(listId, !state.pinned).then((_) {
      refreshAll();
      refresh();
    });
  }

  void onArchived() {
    _listTasksRepository.updateArchived(listId, !state.archived).then((_) {
      refreshAll();
      refresh();
    });
  }

  void onDelete(BuildContext contextPage) {
    _listTasksRepository.delete(state.id).then((_) {
      refreshAll();
      contextPage.pop();
    });
  }

  Future<void> onMarkIncompleteAllTasks() async {
    final tasks = state.tasks.where((task) => task.completed).toList();
    for (final task in tasks) {
      await _tasksRepository.updateCompleted(task.id, false);
    }
    refreshAll();
    refresh();
  }

  Future<void> onMarkCompleteAllTasks() async {
    final tasks = state.tasks.where((task) => !task.completed).toList();
    for (final task in tasks) {
      await _tasksRepository.updateCompleted(task.id, true);
    }
    refreshAll();
    refresh();
  }

  Future<void> onDeleteCompletedAllTasks() async {
    final tasks = state.tasks.where((task) => task.completed).toList();
    if (tasks.isEmpty) return;
    for (final task in tasks) {
      await _tasksRepository.delete(task.id);
    }
    refreshAll();
    refresh();
  }
}
