import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasking/config/i18n/generated/translations.g.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/domain/domain.dart';
import 'package:tasking/presentation/providers/providers.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, Task, Task>((ref, task) {
  final refreshAll = ref.read(homeProvider.notifier).refreshAll;
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

  final _notificationService = NotificationService();
  final _taskRepository = TaskRepository();
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  TextEditingController subtaskAddController = TextEditingController();

  Future<void> onDeleteTask() async {
    await _taskRepository.delete(state.id).then((_) {
      refreshAll();
      refreshList();
    });
  }

  void onToggleCompleted() {
    _taskRepository.updateCompleted(state.id, !state.completed).then((_) {
      refreshAll();
      refreshList();
    });
  }

  void onTitleChanged(String value) {
    _debouncer.run(() {
      final String title = value.trim();
      if (title.isEmpty || state.title == title) return;
      _taskRepository.updateTitle(state.id, title).then((_) {
        refreshAll();
        refreshList();
      });
    });
  }

  void onNoteChanged(String value) {
    _debouncer.run(() async {
      final String note = value.trim();
      if (state.note == note) return;
      _taskRepository.updateNote(state.id, note).then((_) {
        refreshAll();
        refreshList();
      });
    });
  }

  Future<void> onUpdateReminder(BuildContext context) async {
    if (state.reminder != null) {
      showModalBottomSheet(
        context: context,
        builder: (contextModal) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  contextModal.pop();
                  await _dateTimePicker(context);
                },
                shape: const RoundedRectangleBorder(),
                leading: const Icon(BoxIcons.bx_shuffle),
                title: Text(S.common.modals.taskReminder.change),
              ),
              ListTile(
                onTap: () async {
                  contextModal.pop();
                  await onRemoveReminder();
                },
                shape: const RoundedRectangleBorder(),
                iconColor: Colors.redAccent,
                leading: const Icon(BoxIcons.bx_bell_off),
                title: Text(S.common.modals.taskReminder.remove),
              ),
            ],
          ),
        ),
      );
      return;
    }
    await _dateTimePicker(context);
  }

  Future<void> onRemoveReminder() async {
    try {
      await _notificationService.remove(state.id);
      _taskRepository.deleteReminder(state.id).then((_) {
        refreshAll();
        refreshList();
        state.reminder = null;
      });
    } catch (e) {
      MyToast.show(e.toString());
    }
  }

  Future<void> _dateTimePicker(BuildContext context) async {
    final status = await Permission.notification.status;
    if (status.isPermanentlyDenied) {
      MyToast.show(S.common.utils.notifications.isDenied);
      return;
    }
    if (status.isDenied) {
      final request = await Permission.notification.request();
      if (request.isPermanentlyDenied) {
        MyToast.show(S.common.utils.notifications.isDenied);
        return;
      }
    }

    final reminder = await DatTimePicker.show(context);
    if (reminder == null) return;

    try {
      await _notificationService.show(
        id: state.id,
        title: S.common.utils.notifications.title,
        body: state.title,
        dateTime: reminder,
      );

      _taskRepository.updateReminder(state.id, reminder).then((_) {
        refreshAll();
        refreshList();
        state.reminder = reminder;
      });
    } catch (e) {
      MyToast.show('$e');
    }
  }
}
