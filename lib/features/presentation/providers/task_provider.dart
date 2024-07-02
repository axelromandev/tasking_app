// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import 'all_list_tasks_provider.dart';
import 'list_tasks_provider.dart';

final taskProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, Task, Task>((ref, task) {
  final refreshAll = ref.read(allListTasksProvider.notifier).refreshAll;
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
    final status = await Permission.notification.status;
    if (status.isPermanentlyDenied) {
      MyToast.show(S.utils.notifications.isDenied);
      return;
    }
    if (status.isDenied) {
      final request = await Permission.notification.request();
      if (request.isPermanentlyDenied) {
        MyToast.show(S.utils.notifications.isDenied);
        return;
      }
    }

    final reminder = await DatTimePicker.show(context);
    if (reminder == null) return;

    try {
      await NotificationService.show(
        id: state.id,
        title: S.utils.notifications.title,
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
