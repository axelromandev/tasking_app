import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import 'list_tasks_provider.dart';
import 'select_list_id_provider.dart';

final taskAddModalProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final listId = ref.read(selectListIdProvider);
  final refresh = ref.read(listTasksProvider.notifier).refresh;

  return _Notifier(listId: listId, refresh: refresh);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier({
    required int listId,
    required this.refresh,
  }) : super(_State(listId: listId));

  final Future<void> Function() refresh;

  final controller = TextEditingController();
  final focusNode = FocusNode();
  final _taskRepository = TaskRepository();

  void onNameChanged(String value) {
    state = state.copyWith(name: value.trim());
  }

  Future<void> onSubmit() async {
    if (state.name.trim().isEmpty) {
      MyToast.show(S.modals.taskAdd.errorEmptyName);
      return;
    }
    try {
      await _taskRepository.add(state.listId, state.name);
      refresh();
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
  });
  final int listId;
  final String name;

  _State copyWith({
    String? name,
  }) {
    return _State(
      listId: listId,
      name: name ?? this.name,
    );
  }
}
