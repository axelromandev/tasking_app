import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';

final listTasksProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, int>((ref, listId) {
  final refreshAll = ref.read(listsProvider.notifier).refresh;

  return _Notifier(listId, refreshAll);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(this.listId, this.refreshAll) : super(const _State()) {
    refresh();
  }

  final int listId;
  final Future<void> Function() refreshAll;

  final _tasksRepository = TaskRepositoryImpl();
  final _listTasksRepository = ListTasksRepositoryImpl();

  Future<void> refresh() async {
    try {
      final ListTasks list = await _listTasksRepository.get(listId);
      final tasks = await _tasksRepository.getByListId(list.id);

      final pendingTasks =
          tasks.where((task) => task.completedAt == null).toList();
      pendingTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final completedTasks =
          tasks.where((task) => task.completedAt != null).toList();
      completedTasks.sort((a, b) => a.completedAt!.compareTo(b.completedAt!));

      state = state.copyWith(
        list: list,
        pending: pendingTasks,
        completed: completedTasks,
        isLoading: false,
      );
    } catch (e) {
      MyToast.show(e.toString());
    }
  }

  Future<void> onDismissibleTask(int taskId) async {
    await _tasksRepository.delete(taskId).then((_) {
      refresh();
    });
  }

  void onToggleCompleted(int taskId) {
    _tasksRepository.toggleCompleted(taskId).then((_) {
      refresh();
    });
  }

  void onDelete(BuildContext contextPage) {
    _listTasksRepository.delete(listId).then((_) {
      refreshAll();
      contextPage.pop();
    });
  }

  Future<void> onMarkIncompleteAllTasks() async {
    for (final task in state.completed) {
      final newTask = task.toggleCompleted();
      await _tasksRepository.update(newTask);
    }
    refresh();
  }

  Future<void> onMarkCompleteAllTasks() async {
    for (final task in state.pending) {
      final newTask = task.copyWith(
        completedAt: DateTime.now(),
      );
      await _tasksRepository.update(newTask);
    }
    refresh();
  }

  Future<void> onDeleteCompletedAllTasks() async {
    if (state.completed.isEmpty) return;
    for (final task in state.completed) {
      await _tasksRepository.delete(task.id);
    }
    refresh();
  }
}

class _State {
  const _State({
    this.list,
    this.pending = const [],
    this.completed = const [],
    this.isLoading = true,
  });

  final ListTasks? list;
  final List<Task> pending;
  final List<Task> completed;
  final bool isLoading;

  _State copyWith({
    ListTasks? list,
    List<Task>? pending,
    List<Task>? completed,
    bool? isLoading,
  }) {
    return _State(
      list: list ?? this.list,
      pending: pending ?? this.pending,
      completed: completed ?? this.completed,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
