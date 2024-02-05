import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:tasking/app/presentation/modals/delete_task_modal.dart';
import 'package:tasking/core/core.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../data/data.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

final taskProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final refresh = ref.watch(homeProvider.notifier).getAll;
  return _Notifier(refresh);
});

class _Notifier extends StateNotifier<_State> {
  final Future<void> Function() refresh;
  _Notifier(this.refresh) : super(_State());

  final _now = DateTime.now();
  final _taskDataSource = TaskDataSource();

  BuildContext context = navigatorKey.currentContext!;

  void initialize(int id) async {
    final task = await _taskDataSource.get(id);
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
    await showModalBottomSheet<bool?>(
      context: context,
      elevation: 0,
      builder: (_) => const DeleteTaskModal(),
    ).then((value) async {
      if (value == null) return;
      await _taskDataSource.delete(state.task!.id).then((_) async {
        refresh();
        // ignore: use_build_context_synchronously
        navigatorKey.currentContext!.pop();
      });
    });
  }

  void onAddDueDate() async {
    final dateNew = DateTime(_now.year, _now.month, _now.day, 20, 00);
    final dateTomorrow = DateTime(_now.year, _now.month, _now.day + 1, 09, 00);

    showModalBottomSheet(
      context: context,
      builder: (_) => Card(
        margin: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _saveDueDate(dateNew);
                  },
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: const Icon(BoxIcons.bx_calendar),
                  title: Text(S.of(context).calendar_today),
                  trailing: Text(
                      DateFormat().add_MMMMEEEEd().format(dateNew).toString()),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _saveDueDate(dateTomorrow);
                  },
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: const Icon(BoxIcons.bx_calendar),
                  title: Text(S.of(context).calendar_tomorrow),
                  trailing: Text(DateFormat()
                      .add_MMMMEEEEd()
                      .format(dateTomorrow)
                      .toString()),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _customSaveDueDate();
                  },
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: const Icon(BoxIcons.bx_calendar),
                  title: Text(S.of(context).calendar_custom),
                ),
                if (Platform.isAndroid) const Gap(defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _customSaveDueDate() {
    showDateTimePicker(
      currentTime: state.task?.dueDate?.date,
    ).then((date) async {
      if (date == null) return;
      final dateCustom = DateTime(date.year, date.month, date.day, 09, 00);
      _saveDueDate(dateCustom);
    });
  }

  void _saveDueDate(DateTime date) async {
    final task = state.task!;
    task.dueDate = task.dueDate!.copyWith(date: date);
    state = state.copyWith(task: task);
    await _taskDataSource.update(task).then((_) {
      refresh();
    });
  }

  void onRemoveDueDate() async {
    final task = state.task!;
    task.dueDate = null;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task).then((_) {
      refresh();
    });
  }

  void onChangeMessage(String value) async {
    if (value.trim().isEmpty) return;
    final task = state.task!;
    task.message = value;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task).then((_) {
      refresh();
    });
  }

  void onToggleComplete() async {
    final task = state.task!;
    final result = task.isCompleted == null ? DateTime.now() : null;
    task.isCompleted = result;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task).then((_) {
      refresh();
    });
  }

  String formatDate() {
    final date = state.task!.dueDate?.date;
    if (date == null) {
      return S.of(context).button_due_date;
    }
    if (date.day == _now.day && date.month == _now.month) {
      return S.of(context).calendar_today;
    }
    if (date.day == _now.day + 1 && date.month == _now.month) {
      return S.of(context).calendar_tomorrow;
    }
    if (date.year == _now.year) {
      return DateFormat().add_MMMMEEEEd().format(date).toString();
    }
    return DateFormat().add_yMMMMEEEEd().format(date).toString();
  }
}

class _State {
  final Task? task;

  _State({this.task});

  _State copyWith({Task? task}) {
    return _State(task: task ?? this.task);
  }
}
