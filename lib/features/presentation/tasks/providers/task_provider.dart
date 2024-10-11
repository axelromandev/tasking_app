import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, Task, Task>((ref, task) {
  final refreshAll = ref.read(listsProvider.notifier).refresh;
  final refreshList = ref.read(listTasksProvider(task.listId).notifier).refresh;

  return _Notifier(
    task: task,
    refreshAll: refreshAll,
    refreshList: refreshList,
  );
});

class _Notifier extends StateNotifier<Task> {
  _Notifier({
    required Task task,
    required this.refreshAll,
    required this.refreshList,
  }) : super(task);

  final Future<void> Function() refreshAll;
  final Future<void> Function() refreshList;

  // final _notificationService = NotificationService();
  final _taskRepository = TaskRepositoryImpl();
  final _debounce = Debounce(
    delay: const Duration(milliseconds: 300),
  );

  TextEditingController subtaskAddController = TextEditingController();

  Future<void> _refresh() async {
    final task = await _taskRepository.get(state.id);
    state = task;
  }

  Future<void> onDeleteTask() async {
    await _taskRepository.delete(state.id).then((_) {
      refreshAll();
      refreshList();
    });
  }

  void onToggleCompleted() {
    HapticFeedback.heavyImpact();
    final newTask = state.toggleCompleted();
    _taskRepository.update(newTask).then((_) {
      refreshAll();
      refreshList();
    });
  }

  void onTitleChanged(String value) {
    _debounce.run(() {
      final String title = value.trim();
      if (title.isEmpty || state.title == title) return;
      final newTask = state.copyWith(
        title: title,
        updatedAt: DateTime.now(),
      );
      _taskRepository.update(newTask).then((_) {
        _refresh();
        refreshAll();
        refreshList();
      });
    });
  }

  void onNoteChanged(String value) {
    _debounce.run(() async {
      final String note = value.trim();
      if (state.notes == note) return;
      final newTask = state.copyWith(
        notes: note,
        updatedAt: DateTime.now(),
      );
      _taskRepository.update(newTask).then((_) {
        refreshAll();
        refreshList();
      });
    });
  }

  Future<void> onUpdateReminder(BuildContext context) async {
    //   if (state.reminder != null) {
    //     showModalBottomSheet(
    //       context: context,
    //       builder: (contextModal) => SafeArea(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             ListTile(
    //               onTap: () async {
    //                 contextModal.pop();
    //                 await _dateTimePicker(context);
    //               },
    //               shape: const RoundedRectangleBorder(),
    //               leading: const Icon(IconsaxOutline.shuffle),
    //               title: Text(S.modals.taskReminder.change),
    //             ),
    //             ListTile(
    //               onTap: () async {
    //                 contextModal.pop();
    //                 await onRemoveReminder();
    //               },
    //               shape: const RoundedRectangleBorder(),
    //               iconColor: Colors.redAccent,
    //               leading: const Icon(IconsaxOutline.notification),
    //               title: Text(S.modals.taskReminder.remove),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //     return;
    //   }
    //   await _dateTimePicker(context);
  }

  Future<void> onRemoveReminder() async {
    // FIXME: CHANGE TASK REMOVE REMINDER
    // try {
    //   await _notificationService.remove(state.id);
    //   _taskRepository.deleteReminder(state.id).then((_) {
    //     refreshAll();
    //     refreshList();
    //     state.reminder = null;
    //   });
    // } catch (e) {
    //   MyToast.show(e.toString());
    // }
  }

  // Future<void> _dateTimePicker(BuildContext context) async {
  //   final status = await Permission.notification.status;
  //   if (status.isPermanentlyDenied) {
  //     MyToast.show(S.common.utils.notifications.isDenied);
  //     return;
  //   }
  //   if (status.isDenied) {
  //     final request = await Permission.notification.request();
  //     if (request.isPermanentlyDenied) {
  //       MyToast.show(S.common.utils.notifications.isDenied);
  //       return;
  //     }
  //   }

  //   final reminder = await DatTimePicker.show(context);
  //   if (reminder == null) return;

  //   try {
  //     await _notificationService.show(
  //       id: state.id,
  //       title: S.common.utils.notifications.title,
  //       body: state.title,
  //       dateTime: reminder,
  //     );

  //     _taskRepository.updateReminder(state.id, reminder).then((_) {
  //       refreshAll();
  //       refreshList();
  //       state.reminder = reminder;
  //     });
  //   } catch (e) {
  //     MyToast.show('$e');
  //   }
  // }
}
