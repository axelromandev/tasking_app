import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../i18n/generated/translations.g.dart';
import '../../domain/domain.dart';
import 'all_list_tasks_provider.dart';
import 'list_tasks_provider.dart';

final taskAddModalProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, int>((ref, listId) {
  final refreshAll = ref.read(allListTasksProvider.notifier).refreshAll;
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
  final _taskRepository = TaskRepository();

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
    this.reminder,
  });
  final int listId;
  final String name;
  final DateTime? reminder;

  _State copyWith({
    String? name,
    DateTime? reminder,
  }) {
    return _State(
      listId: listId,
      name: name ?? this.name,
      reminder: reminder ?? this.reminder,
    );
  }
}
