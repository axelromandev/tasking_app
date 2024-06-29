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
      refresh();
      refreshAll();
    });
  }

  void onArchived() {
    _listTasksRepository.updateArchived(listId, !state.archived).then((_) {
      refresh();
      refreshAll();
    });
  }

  void onDelete(BuildContext contextPage) {
    _listTasksRepository.delete(state.id).then((_) {
      refreshAll();
      contextPage.pop();
    });
  }

  void onMarkIncompleteAllTasks() {
    // if (state.selected == null) return;
    // if (state.selected!.tasks.isEmpty) return;
    // final tasks = state?.tasks.where((task) => task.completed).toList();
    // for (final task in tasks!) {
    //   task.completed = false;
    //   await _taskRepository.update(task);
    // }
    // await refresh();
  }

  void onMarkCompleteAllTasks() {
    // if (state.selected == null) return;
    // if (state.selected!.tasks.isEmpty) return;
    // final tasks = state?.tasks.where((task) => !task.completed).toList();
    // for (final task in tasks!) {
    //   task.completed = true;
    //   await _taskRepository.update(task);
    // }
    // await refresh();
  }

  void onDeleteCompletedAllTasks() {
    // if (state == null) return;
    // if (state?.tasks == null) return;
    // final tasks = state?.tasks.where((task) => task.completed).toList();
    // for (final task in tasks!) {
    //   await _taskRepository.delete(task.id);
    // }
    // await refresh();
  }
}
