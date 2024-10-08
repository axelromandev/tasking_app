import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/modals/task_notes_modal.dart';
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

  void onNameChanged(String value) {
    state = state.copyWith(name: value.trim());
  }

  void onNotesChanged(BuildContext context) {
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

  void onDatelineChanged(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'mm/dd/yyyy',
                  labelText: 'Set dateline',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(IconsaxOutline.calendar_1),
                  ),
                ),
                onFieldSubmitted: (value) {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
        reminder: state.reminder,
      );
      await _taskRepository.add(newTask);
      refreshList();
      refreshAll();
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
    this.reminder,
  });

  final int listId;
  final String name;
  final String notes;
  final DateTime? reminder;

  _State copyWith({
    String? name,
    String? notes,
    DateTime? reminder,
  }) {
    return _State(
      listId: listId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      reminder: reminder ?? this.reminder,
    );
  }
}
