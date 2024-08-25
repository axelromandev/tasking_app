import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/i18n/generated/translations.g.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/data/data.dart';
import 'package:tasking/presentation/providers/providers.dart';

final taskAddModalProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, int>((ref, listId) {
  final refreshAll = ref.read(homeProvider.notifier).refreshAll;
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

  Future<void> onSubmit() async {
    if (state.name.isEmpty) {
      MyToast.show(S.common.modals.taskAdd.errorEmptyName);
      return;
    }
    try {
      await _taskRepository.add(state.listId, state.name);
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
    this.note,
    this.reminder,
  });
  final int listId;
  final String name;
  final String? note;
  final DateTime? reminder;

  _State copyWith({
    String? name,
    String? note,
    DateTime? reminder,
  }) {
    return _State(
      listId: listId,
      name: name ?? this.name,
      note: note ?? this.note,
      reminder: reminder ?? this.reminder,
    );
  }
}
