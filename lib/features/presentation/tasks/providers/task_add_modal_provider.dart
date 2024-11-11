import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

final taskAddModalProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, (int listId, bool isMyDay)>((ref, config) {
  return _Notifier(config, ref);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(this.config, this.ref) : super(_State());

  final (int listId, bool isMyDau) config;
  final Ref ref;

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
      MyToast.show(S.features.tasks.addModal.errorEmptyName);
      return;
    }
    try {
      final newTask = Task.create(
        listId: config.$1,
        title: state.name,
        notes: state.notes,
        dateline: state.dateline,
        reminder: state.reminder,
      );

      // TODO: implement reminder notification

      await _taskRepository.add(newTask).then((_) {
        ref.read(listTasksProvider(config.$1).notifier).refresh();
        ref.read(listsProvider.notifier).refresh();
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
    this.name = '',
    this.notes = '',
    this.dateline,
    this.reminder,
  });

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
      name: name ?? this.name,
      notes: notes ?? this.notes,
      dateline: dateline ?? this.dateline,
      reminder: reminder ?? this.reminder,
    );
  }

  _State removeDateline() {
    return _State(
      name: name,
      notes: notes,
      reminder: reminder,
    );
  }

  _State removeReminder() {
    return _State(
      name: name,
      notes: notes,
      dateline: dateline,
    );
  }
}
