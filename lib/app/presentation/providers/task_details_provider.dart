import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

final taskDetailsProvider =
    StateNotifierProvider.autoDispose<TaskDetailsNotifier, Task?>((ref) {
  return TaskDetailsNotifier(ref);
});

class TaskDetailsNotifier extends StateNotifier<Task?> {
  final Ref ref;
  TaskDetailsNotifier(this.ref) : super(null);

  BuildContext context = navigatorKey.currentContext!;

  void initialize(Task task) async {
    state = task;
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
            backgroundColor: Colors.red.shade800,
            child: Text(S.of(context).button_delete_task),
          ),
          const SizedBox(height: defaultPadding),
          CustomFilledButton(
            onPressed: () => context.pop(),
            child: Text(S.of(context).button_cancel),
          ),
        ],
      ),
    ).then((value) async {
      if (value == null || state == null) return;

      await ref.read(taskProvider.notifier).deleteTask(state!).then((value) {
        context.pop();
      });
    });
  }

  void onAddDueDate(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final language = S.of(context).language;

    late picker.LocaleType localeType = picker.LocaleType.en;
    if (language == 'es') {
      localeType = picker.LocaleType.es;
    }

    picker.DatePicker.showDatePicker(
      context,
      theme: picker.DatePickerTheme(
        backgroundColor: cardBackgroundColor,
        cancelStyle: style.bodyLarge!,
        doneStyle: style.bodyLarge!.copyWith(color: colors.primary),
        itemStyle: style.bodyLarge!.copyWith(color: colors.onBackground),
      ),
      maxTime: DateTime.now(),
      currentTime: DateTime.now(),
      locale: localeType,
      onConfirm: (date) {},
    );
  }

  void onAddReminder(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final language = S.of(context).language;

    late picker.LocaleType localeType = picker.LocaleType.en;

    if (language == 'es') {
      localeType = picker.LocaleType.es;
    }

    picker.DatePicker.showDateTimePicker(
      context,
      theme: picker.DatePickerTheme(
        backgroundColor: cardBackgroundColor,
        cancelStyle: style.bodyLarge!,
        doneStyle: style.bodyLarge!.copyWith(color: colors.primary),
        itemStyle: style.bodyLarge!.copyWith(color: colors.onBackground),
      ),
      maxTime: DateTime.now(),
      currentTime: DateTime.now(),
      locale: localeType,
      onConfirm: (date) {},
    );
  }
}
