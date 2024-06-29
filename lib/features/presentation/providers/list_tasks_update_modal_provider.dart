import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import 'list_tasks_provider.dart';

final listTasksUpdateModalProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, ListTasks>((ref, list) {
  final refreshList = ref.read(listTasksProvider(list.id).notifier).refresh;

  return _Notifier(list, refreshList);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(this.list, this.refreshList) : super(_State()) {
    state = state.init(list);
  }

  final ListTasks list;
  final Future<void> Function() refreshList;

  final expansionTileController = ExpansionTileController();

  final _listTasksRepository = ListTasksRepository();

  void onNameChanged(String value) {
    state = state.copyWith(title: value.trim());
  }

  Future<void> onColorChanged(Color value) async {
    state = state.copyWith(color: value);
    await Future.delayed(const Duration(milliseconds: 100));
    expansionTileController.collapse();
  }

  Future<void> onSubmit(BuildContext context) async {
    if (state.title.isEmpty) {
      MyToast.show(S.modals.listTasksUpdate.errorEmptyName);
      return;
    }

    await _listTasksRepository
        .update(list.id, state.title, state.color)
        .then((_) {
      refreshList();
      context.pop();
    });
  }
}

class _State {
  _State({
    this.title = '',
    this.color = Colors.amber,
  });
  final String title;
  final Color color;

  _State copyWith({
    String? title,
    Color? color,
  }) {
    return _State(
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }

  _State init(ListTasks list) {
    return _State(
      title: list.title,
      color: Color(list.color!),
    );
  }
}
