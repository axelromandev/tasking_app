import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final importantProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _initialize();
  }

  final _taskRepository = TaskRepositoryImpl();

  Future<void> _initialize() async {
    try {
      final tasks = await _taskRepository.getImportant();
      if (state.showCompleted) {
        state = state.copyWith(tasks: tasks);
      } else {
        state = state.copyWith(
          tasks: tasks.where((t) => t.completedAt == null).toList(),
        );
      }
    } catch (e) {
      log(e.toString(), name: 'importantProvider');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void refresh() {
    state = state.copyWith(isLoading: true);
    _initialize();
  }

  void toggleShowCompleted() {
    state = state.copyWith(showCompleted: !state.showCompleted);
    _initialize();
  }

  void toggleCompleted(Task task) {
    final completedAt = task.completedAt == null ? DateTime.now() : null;
    _taskRepository.update(task.id, {
      'completed_at': completedAt?.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      _initialize();
    });
  }

  void uncheckImportant(int taskId) {
    _taskRepository.update(taskId, {
      'is_important': 0,
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      _initialize();
    });
  }

  void delete(int taskId) {
    _taskRepository.delete(taskId).then((_) {
      _initialize();
    });
  }
}

class _State {
  _State({
    this.isLoading = true,
    this.showCompleted = true,
    this.tasks = const [],
  });

  final bool isLoading;
  final bool showCompleted;
  final List<Task> tasks;

  _State copyWith({
    bool? isLoading,
    bool? showCompleted,
    List<Task>? tasks,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      showCompleted: showCompleted ?? this.showCompleted,
      tasks: tasks ?? this.tasks,
    );
  }
}
