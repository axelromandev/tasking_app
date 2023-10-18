import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, List<Task>>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<List<Task>> {
  final Ref ref;

  HomeNotifier(this.ref) : super([]) {
    getAll();
  }

  final _taskRepository = TaskRepositoryImpl();

  Future<void> getAll() async {
    final tasks = await _taskRepository.getAll();
    state = tasks;
  }

  void onSubmit(String value) async {
    ref.read(controllerProvider).clear();
    if (value.trim().isEmpty) return;

    final task = Task(
      message: value,
      createAt: DateTime.now(),
    );

    await _taskRepository.write(task);
    getAll();
  }

  void onToggleCheck(Task task) async {
    task.isCompleted = task.isCompleted == null ? DateTime.now() : null;
    await _taskRepository.write(task);
    getAll();
  }
}

final controllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
