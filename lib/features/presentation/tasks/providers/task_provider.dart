import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';

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
  final _stepRepository = StepRepositoryImpl();
  final _debounce = Debounce();

  Future<void> _initialize() async {
    try {
      final task = await _taskRepository.get(taskId);
      final steps = await _stepRepository.getAll(taskId);
      state = state.copyWith(
        listId: task.listId,
        title: task.title,
        completedAt: task.completedAt,
        reminder: task.reminder,
        dateline: task.dateline,
        notes: task.notes,
        steps: steps,
        updatedAt: task.updatedAt,
        isImportant: task.isImportant,
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

  void onToggleImportant() {
    _taskRepository.update(taskId, {
      'is_important': state.isImportant ? 0 : 1,
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      state = state.copyWith(isImportant: !state.isImportant);
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

  // Dateline

  void onChangeDateline(BuildContext context) {
    showModalBottomSheet<DateTime?>(
      context: context,
      builder: (_) => TaskDatelineModal(value: state.dateline),
    ).then((value) {
      if (value == null) return;
      _taskRepository.update(taskId, {
        'dateline': value.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }).then((_) {
        state = state.copyWith(dateline: value);
        ref.read(listTasksProvider(state.listId).notifier).refresh();
      });
    });
  }

  void onRemoveDateline() {
    _taskRepository.update(taskId, {
      'dateline': null,
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      state = state.removeDateline();
      ref.read(listTasksProvider(state.listId).notifier).refresh();
    });
  }

  // Notes

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

  // Steps

  Future<void> onAddStep(String value) async {
    await _stepRepository.add(taskId, value).then((_) {
      _stepRepository.getAll(taskId).then((steps) {
        state = state.copyWith(steps: steps);
      });
      ref.read(listTasksProvider(state.listId).notifier).refresh();
    });
  }

  void deleteStep(int stepId) {
    _stepRepository.delete(stepId).then((_) {
      final steps = state.steps.where((s) => s.id != stepId).toList();
      state = state.copyWith(steps: steps);
      ref.read(listTasksProvider(state.listId).notifier).refresh();
    });
  }

  void toggleStepCompleted(int stepId) {
    final StepTask step = state.steps.firstWhere((s) => s.id == stepId);
    final String? completedAt =
        step.completedAt == null ? DateTime.now().toIso8601String() : null;
    _stepRepository.update(stepId, {'completed_at': completedAt}).then((_) {
      _stepRepository.getAll(taskId).then((steps) {
        state = state.copyWith(steps: steps);
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
    this.isImportant = false,
    this.isLoading = true,
  });

  final int listId;
  final String title;
  final List<StepTask> steps;
  final DateTime? completedAt;
  final DateTime? reminder;
  final DateTime? dateline;
  final String notes;
  final DateTime? updatedAt;
  final bool isImportant;
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
      isImportant: isImportant,
      isLoading: isLoading,
    );
  }

  _State removeDateline() {
    return _State(
      listId: listId,
      title: title,
      steps: steps,
      completedAt: completedAt,
      reminder: reminder,
      notes: notes,
      updatedAt: DateTime.now(),
      isImportant: isImportant,
      isLoading: isLoading,
    );
  }

  _State copyWith({
    int? listId,
    String? title,
    List<StepTask>? steps,
    DateTime? completedAt,
    DateTime? reminder,
    DateTime? dateline,
    String? notes,
    DateTime? updatedAt,
    bool? isImportant,
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
      isImportant: isImportant ?? this.isImportant,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
