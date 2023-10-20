import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

final taskProvider =
    StateNotifierProvider.autoDispose<TaskNotifier, TaskState>((ref) {
  final refresh = ref.watch(homeProvider.notifier).getAll;
  return TaskNotifier(refresh: refresh);
});

class TaskNotifier extends StateNotifier<TaskState> {
  final Future<void> Function() refresh;

  TaskNotifier({required this.refresh}) : super(TaskState());

  final _taskRepository = TaskRepositoryImpl();

  BuildContext context = navigatorKey.currentContext!;

  void initialize(int id) async {
    final task = await _taskRepository.get(id);
    state = state.copyWith(task: task);
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void onDelete() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    await showDialog<bool?>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          S.of(context).dialog_delete_title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          S.of(context).dialog_delete_subtitle,
          textAlign: TextAlign.center,
        ),
        actions: [
          CustomFilledButton(
            onPressed: () => context.pop(true),
            foregroundColor: Colors.red,
            backgroundColor: Colors.red.shade900.withOpacity(.1),
            child: Text(S.of(context).button_delete_task),
          ),
          const SizedBox(height: defaultPadding),
          CustomFilledButton(
            onPressed: () => context.pop(),
            backgroundColor: isDarkMode ? cardDarkColor : cardLightColor,
            foregroundColor: isDarkMode ? Colors.white : Colors.black,
            child: Text(S.of(context).button_cancel),
          ),
        ],
      ),
    ).then((value) async {
      if (value == null) return;
      await _taskRepository.delete(state.task!.id).then((value) {
        refresh();
        navigatorKey.currentContext!.pop();
      });
    });
  }

  void onAddDueDate() {
    final style = Theme.of(context).textTheme;
    final language = S.of(context).language;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    late picker.LocaleType localeType = picker.LocaleType.en;
    if (language == 'es') {
      localeType = picker.LocaleType.es;
    }

    picker.DatePicker.showDatePicker(
      context,
      theme: picker.DatePickerTheme(
        backgroundColor: isDarkMode ? cardDarkColor : cardLightColor,
        cancelStyle: style.bodyLarge!,
        doneStyle: style.bodyLarge!,
        itemStyle: style.bodyLarge!.copyWith(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      currentTime: state.task?.dueDate ?? DateTime.now(),
      locale: localeType,
      onConfirm: (date) async {
        final task = state.task!;
        task.dueDate = date;
        state = state.copyWith(task: task);
        await _taskRepository.write(task);
        await refresh();
      },
    );
  }

  void onRemoveDueDate() async {
    final task = state.task!;
    task.dueDate = null;
    state = state.copyWith(task: task);
    await _taskRepository.write(task);
    refresh();
  }

  void onAddReminder() {
    final style = Theme.of(context).textTheme;
    final language = S.of(context).language;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    late picker.LocaleType localeType = picker.LocaleType.en;

    if (language == 'es') {
      localeType = picker.LocaleType.es;
    }

    picker.DatePicker.showDateTimePicker(
      context,
      theme: picker.DatePickerTheme(
        backgroundColor: isDarkMode ? cardDarkColor : cardLightColor,
        cancelStyle: style.bodyLarge!,
        doneStyle: style.bodyLarge!,
        itemStyle: style.bodyLarge!.copyWith(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      maxTime: DateTime.now(),
      currentTime: state.task!.reminder ?? DateTime.now(),
      locale: localeType,
      onConfirm: (date) async {
        final task = state.task!;
        task.reminder = date;
        state = state.copyWith(task: task);
        await _taskRepository.write(task);
        await refresh();

        //TODO: add local notification here
      },
    );
  }

  void onRemoveReminder() async {
    final task = state.task!;
    task.reminder = null;
    state = state.copyWith(task: task);
    await _taskRepository.write(task);
    refresh();
  }

  void onChangeMessage(String value) async {
    if (value.trim().isEmpty) return;
    final task = state.task!;
    task.message = value;
    state = state.copyWith(task: task);
    await _taskRepository.write(task);
    refresh();
  }

  void onToggleComplete() async {
    final task = state.task!;
    final result = task.isCompleted == null ? DateTime.now() : null;
    task.isCompleted = result;
    state = state.copyWith(task: task);
    await _taskRepository.write(task);
    refresh();
  }
}

class TaskState {
  final Task? task;

  TaskState({this.task});

  TaskState copyWith({Task? task}) {
    return TaskState(task: task ?? this.task);
  }
}
