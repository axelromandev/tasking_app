import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/presentation/modals/delete_task_modal.dart';
import 'package:tasking/core/core.dart';

import '../../../config/config.dart';
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
      await _taskDataSource.delete(state.task!.id).then((value) {
        if (state.task?.reminder != null) {
          // FIXME: notification service

          // NotificationService.cancel(state.task!.id);
        }
        refresh();
        navigatorKey.currentContext!.pop();
      });
    });
  }

  void onAddDueDate() async {
    final now = DateTime.now();

    final dateNew = DateTime(now.year, now.month, now.day, 09, 00);
    final dateTomorrow = DateTime(now.year, now.month, now.day + 1, 09, 00);
    final dateWeekend = _getNextSaturday();

    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
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
                leading: const Icon(BoxIcons.bx_calendar),
                title: const Text('Hoy'),
                trailing: Text(dateNew.toString()),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  _saveDueDate(dateTomorrow);
                },
                leading: const Icon(BoxIcons.bx_calendar),
                title: const Text('Mañana'),
                trailing: Text(dateTomorrow.toString()),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  _saveDueDate(dateWeekend);
                },
                leading: const Icon(BoxIcons.bx_calendar),
                title: const Text('Este fin de semana'),
                trailing: Text(dateWeekend.toString()),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  showDateTimePicker(
                    currentTime: state.task?.dueDate,
                  ).then((date) async {
                    if (date == null) return;
                    _saveDueDate(date);
                  });
                },
                leading: const Icon(BoxIcons.bx_calendar),
                title: const Text('Custom'),
              ),
              if (Platform.isAndroid) const Gap(defaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _getNextSaturday() {
    DateTime now = DateTime.now();
    int daysToAdd;
    if (now.weekday <= DateTime.saturday) {
      daysToAdd = DateTime.saturday - now.weekday;
    } else {
      daysToAdd = 6;
    }
    return now.add(Duration(days: daysToAdd));
  }

  void _saveDueDate(DateTime date) async {
    final task = state.task!;
    task.dueDate = date;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task);
    await refresh();
  }

  void onRemoveDueDate() async {
    final task = state.task!;
    task.dueDate = null;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task);
    refresh();
  }

  void onAddReminder() async {
    showDateTimePicker(
      minTime: DateTime.now().add(const Duration(days: 1)),
      currentTime: state.task?.reminder,
    ).then((date) async {
      if (date == null) return;
      final task = state.task!;
      task.reminder = date;
      state = state.copyWith(task: task);
      await _taskDataSource.update(task).then((_) {
        // FIXME: notification service

        // NotificationService.showSchedule(
        //   id: state.task!.id,
        //   title: S.of(context).reminder_notification_title,
        //   body: state.task!.message,
        //   scheduledDate: date,
        // );
      });
      await refresh();
    });
  }

  void onRemoveReminder() async {
    final task = state.task!;
    task.reminder = null;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task).then((_) {
      // FIXME: notification service

      // NotificationService.cancel(state.task!.id);
    });
    refresh();
  }

  void onChangeMessage(String value) async {
    if (value.trim().isEmpty) return;
    final task = state.task!;
    task.message = value;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task).then((_) {
      if (state.task?.reminder != null) {
        // FIXME: notification service

        // NotificationService.showSchedule(
        //   id: state.task!.id,
        //   title: S.of(context).reminder_notification_title,
        //   body: state.task!.message,
        //   scheduledDate: state.task!.reminder!,
        // );
      }
    });
    refresh();
  }

  void onToggleComplete() async {
    final task = state.task!;
    final result = task.isCompleted == null ? DateTime.now() : null;
    task.isCompleted = result;
    state = state.copyWith(task: task);
    await _taskDataSource.update(task);
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
