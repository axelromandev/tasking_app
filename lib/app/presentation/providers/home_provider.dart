import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

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

  void onRestoreDataApp() async {
    BuildContext context = navigatorKey.currentContext!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    await showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).dialog_restore_title),
        content: Text(
          S.of(context).dialog_restore_subtitle,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomFilledButton(
                  onPressed: () => context.pop(),
                  backgroundColor: isDarkMode ? cardDarkColor : cardLightColor,
                  foregroundColor: isDarkMode ? Colors.white : Colors.black,
                  child: Text(S.of(context).button_cancel),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomFilledButton(
                  onPressed: () => context.pop(true),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  child: Text(S.of(context).button_restore),
                ),
              ),
            ],
          ),
        ],
      ),
    ).then((value) async {
      if (value == null) return;
      _restore();
      context.pop();
    });
  }

  void _restore() async {
    await _taskRepository.restore();
    getAll();
  }
}

final controllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
