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
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      log(e.toString(), name: 'importantProvider');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class _State {
  _State({
    this.isLoading = true,
    this.tasks = const [],
  });

  final bool isLoading;
  final List<Task> tasks;

  _State copyWith({
    bool? isLoading,
    List<Task>? tasks,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
    );
  }
}
