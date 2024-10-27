import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/lists/lists.dart';

final listTasksProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, int>((ref, listId) {
  final refreshAll = ref.read(listsProvider.notifier).refresh;
  final onChangeView = ref.read(homeProvider.notifier).onChangeView;
  final scaffoldKey = ref.read(homeProvider.notifier).scaffoldKey;

  return _Notifier(listId, refreshAll, onChangeView, scaffoldKey);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(
    this.listId,
    this.refreshAll,
    this.onChangeView,
    this.scaffoldKey,
  ) : super(const _State()) {
    refresh();
  }

  final int listId;
  final Future<void> Function() refreshAll;
  final void Function(TypeView) onChangeView;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final _tasksRepository = TaskRepositoryImpl();
  final _listTasksRepository = ListTasksRepositoryImpl();

  Future<void> refresh() async {
    try {
      final ListTasks list = await _listTasksRepository.get(listId);
      final tasks = await _tasksRepository.getByListId(list.id);

      final pendingTasks =
          tasks.where((task) => task.completedAt == null).toList();
      pendingTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

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
    _tasksRepository.get(taskId).then((task) {
      final completedAt = task.completedAt == null ? DateTime.now() : null;
      _tasksRepository.update(taskId, {
        'completed_at': completedAt?.toIso8601String(),
      }).then((_) {
        refresh();
      });
    });
  }

  void onToggleImportant(int taskId) {
    _tasksRepository.get(taskId).then((task) {
      _tasksRepository.update(taskId, {
        'is_important': task.isImportant ? 0 : 1,
      }).then((_) {
        refresh();
      });
    });
  }

  void onDelete() {
    _listTasksRepository.delete(listId).then((_) {
      refreshAll();
      onChangeView(TypeView.home);
      scaffoldKey.currentState?.openDrawer();
    });
  }

  Future<void> onMarkIncompleteAllTasks() async {
    for (final task in state.completed) {
      await _tasksRepository.update(task.id, {
        'completed_at': null,
      });
    }
    refresh();
  }

  Future<void> onMarkCompleteAllTasks() async {
    for (final task in state.pending) {
      await _tasksRepository.update(task.id, {
        'completed_at': DateTime.now().toIso8601String(),
      });
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
