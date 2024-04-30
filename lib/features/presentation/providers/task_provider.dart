// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../modals/delete_task_modal.dart';
import '../presentation.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, Task>((ref, task) {
  final refresh = ref.watch(homeProvider.notifier).getAll;
  return _Notifier(task: task, refresh: refresh);
});

class _Notifier extends StateNotifier<_State> {
  final Task task;
  final Future<void> Function() refresh;

  _Notifier({
    required this.task,
    required this.refresh,
  }) : super(_State(task: task));

  // final _now = DateTime.now();
  final _taskRepository = TaskRepository();

  Future<void> onDelete(BuildContext context) async {
    await showModalBottomSheet<bool?>(
      context: context,
      elevation: 0,
      builder: (_) => const DeleteTaskModal(),
    ).then((value) async {
      if (value == null) return;
      await _taskRepository.delete(state.task.id).then((_) async {
        if (state.task.reminder != null && state.task.reminder != null) {
          await NotificationService.cancel(state.task.id);
        }
        refresh();
        navigatorGlobalKey.currentContext!.pop();
      });
    });
  }

  Future<void> onAddDueDate(BuildContext context) async {
    // final dateToday = DateTime(_now.year, _now.month, _now.day, 23, 59);
    // final dateTomorrow = DateTime(_now.year, _now.month, _now.day + 1, 23, 59);

    // await showModalBottomSheet<DateTime?>(
    //   context: context,
    //   elevation: 0,
    //   builder: (_) => Container(
    //     padding: const EdgeInsets.all(defaultPadding),
    //     child: SafeArea(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           ListTile(
    //             onTap: () => Navigator.pop(context, dateToday),
    //             iconColor: Theme.of(context).colorScheme.primary,
    //             leading: const Icon(BoxIcons.bx_calendar),
    //             title: Text(S.of(context).calendar_today),
    //             trailing: Text(
    //               DateFormat('EEEE, d MMMM').format(dateToday).toString(),
    //             ),
    //           ),
    //           ListTile(
    //             onTap: () => Navigator.pop(context, dateTomorrow),
    //             iconColor: Theme.of(context).colorScheme.primary,
    //             leading: const Icon(BoxIcons.bx_calendar),
    //             title: Text(S.of(context).calendar_tomorrow),
    //             trailing: Text(
    //                 DateFormat('EEEE, d MMMM').format(dateTomorrow).toString()),
    //           ),
    //           const Divider(color: Colors.white12),
    //           ListTile(
    //             onTap: () {
    //               Navigator.pop(context);
    //               _customDateTime(context);
    //             },
    //             iconColor: Theme.of(context).colorScheme.primary,
    //             leading: const Icon(BoxIcons.bx_calendar),
    //             title: Text(S.of(context).calendar_custom),
    //           ),
    //           if (Platform.isAndroid) const Gap(defaultPadding),
    //         ],
    //       ),
    //     ),
    //   ),
    // ).then((value) async {
    //   if (value == null) return;
    //   final task = state.task;
    //   task.reminder = DueDate(date: value);
    //   state = state.copyWith(task: task);
    //   await _taskRepository.update(task).then((_) {
    //     refresh();
    //   });
    // });
  }

  Future<void> _customDateTime(BuildContext context) async {
    // await showModalBottomSheet<DueDate?>(
    //   context: context,
    //   elevation: 0,
    //   useSafeArea: true,
    //   isScrollControlled: true,
    //   backgroundColor: MyColors.backgroundDark,
    //   builder: (_) => const SelectDateTimeModal(),
    // ).then((value) async {
    //   if (value == null) return;
    //   _saveCustomDate(value);
    // });
  }

  Future<void> onEditDueDate(BuildContext context) async {
    // await showModalBottomSheet<DueDate?>(
    //   context: context,
    //   elevation: 0,
    //   useSafeArea: true,
    //   isScrollControlled: true,
    //   backgroundColor: MyColors.backgroundDark,
    //   builder: (_) => SelectDateTimeModal(
    //     initialDueDate: state.task.reminder,
    //   ),
    // ).then((value) async {
    //   if (value == null) return;
    //   _saveCustomDate(value);
    // });
  }

  Future<void> _saveCustomDate(DateTime value) async {
    // final task = state.task;
    // task.reminder = value;
    // state = state.copyWith(task: task);
    // await _taskRepository.update(task).then((_) async {
    //   refresh();
    // });
    // _saveNotification();
  }

  Future<void> _saveNotification() async {
    // final task = state.task;
    // if (task.reminder != null && task.reminder!.isReminder) {
    //   await NotificationService.showScheduleNotification(
    //     id: task.id,
    //     title: task.message,
    //     body: DateFormat('E, d MMM y,')
    //         .add_jm()
    //         .format(task.reminder!.date!)
    //         .toString(),
    //     scheduledDate: task.reminder!.date!,
    //   );
    // }
  }

  Future<void> onRemoveDueDate() async {
    // final task = state.task;
    // task.reminder = null;
    // state = state.copyWith(task: task);
    // await _taskRepository.update(task).then((_) {
    //   refresh();
    // });
    // if (task.reminder != null && task.reminder!.isReminder) {
    //   await NotificationService.cancel(task.id);
    // }
  }

  Future<void> onChangeMessage(String value) async {
    // if (value.trim().isEmpty) return;
    // final task = state.task;
    // task.message = value;
    // state = state.copyWith(task: task);
    // await _taskRepository.update(task).then((_) {
    //   refresh();
    // });
    // _saveNotification();
  }

  Future<void> onToggleComplete() async {
    // final task = state.task;
    // final result = task.completed == null ? DateTime.now() : null;
    // task.completed = result;
    // state = state.copyWith(task: task);
    // await _taskRepository.update(task).then((_) {
    //   refresh();
    // });
    // await NotificationService.cancel(task.id);
  }
}

class _State {
  final Task task;

  _State({
    required this.task,
  });

  _State copyWith({
    Task? task,
  }) {
    return _State(
      task: task ?? this.task,
    );
  }
}
