import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeState()) {
    getAll();
  }

  final _taskRepository = TaskRepositoryImpl();

  Future<void> getAll() async {
    final tasks = await _taskRepository.getAll();
    state = state.copyWith(tasks: tasks);
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

  void onRestoreDataApp() async {
    BuildContext context = navigatorKey.currentContext!;
    await showModalBottomSheet<bool?>(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).dialog_restore_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  S.of(context).dialog_restore_subtitle,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Gap(defaultPadding),
              CustomFilledButton(
                onPressed: () => context.pop(true),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                child: Text(S.of(context).settings_button_restore_app),
              ),
            ],
          ),
        ),
      ),
    ).then((value) async {
      if (value == null) return;
      _restore();
      context.pop();
    });
  }

  void _restore() async {
    await NotificationService.cancelAll();
    await _taskRepository.restore();
    getAll();
  }
}

class HomeState {
  final List<Task> tasks;
  final DateTime? date;

  HomeState({
    this.tasks = const [],
    this.date,
  });

  HomeState copyWith({
    List<Task>? tasks,
    DateTime? date,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      date: date,
    );
  }
}

final controllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
