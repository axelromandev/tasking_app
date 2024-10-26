import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, int>((ref, taskId) {
  return _Notifier(ref, taskId);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(this.ref, this.taskId) : super(_State()) {
    _initialize();
  }

  final Ref ref;
  final int taskId;

  // final _notificationService = NotificationService();
  final _taskRepository = TaskRepositoryImpl();
  final _debounce = Debounce();

  Future<void> _initialize() async {
    try {
      final task = await _taskRepository.get(taskId);
      state = state.copyWith(
        listId: task.listId,
        title: task.title,
        completedAt: task.completedAt,
        reminder: task.reminder,
        dateline: task.dateline,
        notes: task.notes,
        updatedAt: task.updatedAt,
      );
    } catch (e) {
      log(e.toString(), name: 'TaskProvider');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> onDeleteTask(BuildContext pageContext) async {
    await _taskRepository.delete(taskId).then((_) {
      ref.read(listTasksProvider(state.listId).notifier).refresh();
      pageContext.pop();
    });
  }

  void onToggleCompleted() {
    final completedAt = state.completedAt == null ? DateTime.now() : null;
    _taskRepository.update(taskId, {
      'completed_at': completedAt?.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      state = state.toggleCompleted();
      ref.read(listTasksProvider(state.listId).notifier).refresh();
    });
  }

  void onTitleChanged(String value) {
    _debounce.run(() {
      final String title = value.trim();
      if (title.isEmpty || state.title == title) return;
      final updatedAt = DateTime.now();
      _taskRepository.update(
        taskId,
        {
          'title': title,
          'updated_at': updatedAt.toIso8601String(),
        },
      ).then((_) {
        state = state.copyWith(title: title, updatedAt: updatedAt);
        ref.read(listTasksProvider(state.listId).notifier).refresh();
      });
    });
  }

  void onNoteChanged(String value) {
    _debounce.run(() async {
      final String note = value.trim();
      if (state.notes == note) return;
      final updatedAt = DateTime.now();
      await _taskRepository.update(
        taskId,
        {
          'notes': note,
          'updated_at': updatedAt.toIso8601String(),
        },
      ).then((_) {
        state = state.copyWith(notes: note, updatedAt: updatedAt);
        ref.read(listTasksProvider(state.listId).notifier).refresh();
      });
    });
  }
}

class _State {
  _State({
    this.listId = 0,
    this.title = '',
    this.steps = const [],
    this.completedAt,
    this.reminder,
    this.dateline,
    this.notes = '',
    this.updatedAt,
    this.isLoading = true,
  });

  final int listId;
  final String title;
  final List<StepsTask> steps;
  final DateTime? completedAt;
  final DateTime? reminder;
  final DateTime? dateline;
  final String notes;
  final DateTime? updatedAt;
  final bool isLoading;

  _State toggleCompleted() {
    return _State(
      listId: listId,
      title: title,
      steps: steps,
      completedAt: completedAt == null ? DateTime.now() : null,
      reminder: reminder,
      dateline: dateline,
      notes: notes,
      updatedAt: DateTime.now(),
      isLoading: isLoading,
    );
  }

  _State copyWith({
    int? listId,
    String? title,
    List<StepsTask>? steps,
    DateTime? completedAt,
    DateTime? reminder,
    DateTime? dateline,
    String? notes,
    DateTime? updatedAt,
    bool? isLoading,
  }) {
    return _State(
      listId: listId ?? this.listId,
      title: title ?? this.title,
      steps: steps ?? this.steps,
      completedAt: completedAt ?? this.completedAt,
      reminder: reminder ?? this.reminder,
      dateline: dateline ?? this.dateline,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
