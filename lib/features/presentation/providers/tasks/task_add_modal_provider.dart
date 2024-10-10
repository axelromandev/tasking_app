import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/modals/task_dateline_modal.dart';
import 'package:tasking/features/presentation/shared/modals/task_notes_modal.dart';
import 'package:tasking/features/presentation/shared/modals/task_reminder_modal.dart';
import 'package:tasking/i18n/i18n.dart';

final taskAddModalProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, int>((ref, listId) {
  final refreshAll = ref.read(listsProvider.notifier).refresh;
  final refreshList = ref.read(listTasksProvider(listId).notifier).refresh;

  return _Notifier(listId, refreshAll, refreshList);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(
    int listId,
    this.refreshAll,
    this.refreshList,
  ) : super(_State(listId: listId));

  final Future<void> Function() refreshAll;
  final Future<void> Function() refreshList;

  final controller = TextEditingController();
  final focusNode = FocusNode();
  final _taskRepository = TaskRepositoryImpl();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onNameChanged(String value) {
    state = state.copyWith(name: value.trim());
  }

  void openDatelineModal(BuildContext context) {
    showModalBottomSheet<DateTime?>(
      context: context,
      builder: (context) => TaskDatelineModal(
        value: state.dateline,
        onDelete: () {
          state = state.removeDateline();
        },
      ),
    ).then((value) {
      if (value == null) return;
      state = state.copyWith(dateline: value);
    });
  }

  void openReminderModal(BuildContext context) {
    showModalBottomSheet<DateTime?>(
      context: context,
      builder: (context) => TaskReminderModal(
        value: state.reminder,
        onDelete: () {
          state = state.removeReminder();
        },
      ),
    ).then((value) {
      if (value == null) return;
      state = state.copyWith(reminder: value);
    });
  }

  void openNotesModal(BuildContext context) {
    showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (context) => TaskNotesModal(
        value: state.notes,
      ),
    ).then((value) {
      if (value == null) return;
      state = state.copyWith(notes: value);
    });
  }

  Future<void> onSubmit() async {
    if (state.name.isEmpty) {
      MyToast.show(S.modals.taskAdd.errorEmptyName);
      return;
    }
    try {
      final newTask = Task.create(
        listId: state.listId,
        title: state.name,
        notes: state.notes,
        dateline: state.dateline,
        reminder: state.reminder,
      );

      // TODO: implement reminder notification

      await _taskRepository.add(newTask).then((_) {
        refreshList();
        refreshAll();
      });
    } catch (e) {
      MyToast.show(e.toString());
    } finally {
      _clean();
    }
  }

  void _clean() {
    controller.clear();
    state = state.copyWith(name: '');
  }
}

class _State {
  _State({
    required this.listId,
    this.name = '',
    this.notes = '',
    this.dateline,
    this.reminder,
  });

  final int listId;
  final String name;
  final String notes;
  final DateTime? dateline;
  final DateTime? reminder;

  _State copyWith({
    String? name,
    String? notes,
    DateTime? dateline,
    DateTime? reminder,
  }) {
    return _State(
      listId: listId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      dateline: dateline ?? this.dateline,
      reminder: reminder ?? this.reminder,
    );
  }

  _State removeDateline() {
    return _State(
      listId: listId,
      name: name,
      notes: notes,
      reminder: reminder,
    );
  }

  _State removeReminder() {
    return _State(
      listId: listId,
      name: name,
      notes: notes,
      dateline: dateline,
    );
  }
}
