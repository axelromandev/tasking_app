import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import 'list_tasks_provider.dart';

final listTasksUpdateModalProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, ListTasks>((ref, list) {
  final refresh = ref.read(listTasksProvider.notifier).refresh;

  return _Notifier(list: list, refresh: refresh);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier({
    required this.list,
    required this.refresh,
  }) : super(_State()) {
    state = state.init(list);
  }

  final ListTasks list;
  final Future<void> Function() refresh;

  final expansionTileController = ExpansionTileController();

  final _listTasksRepository = ListTasksRepository();

  void onNameChanged(String value) {
    state = state.copyWith(name: value);
  }

  Future<void> onColorChanged(Color value) async {
    state = state.copyWith(color: value);
    await Future.delayed(const Duration(milliseconds: 100));
    expansionTileController.collapse();
  }

  Future<void> onSubmit(BuildContext context) async {
    if (state.name.trim().isEmpty) {
      MyToast.show(S.modals.listTasksUpdate.errorEmptyName);
      return;
    }

    list.name = state.name;
    list.color = state.color.value;

    await _listTasksRepository.update(list).then((_) {
      refresh();
      context.pop();
    });
  }
}

class _State {
  _State({
    this.name = '',
    this.color = Colors.amber,
  });
  final String name;
  final Color color;

  _State copyWith({
    String? name,
    Color? color,
  }) {
    return _State(
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  _State init(ListTasks list) {
    return _State(
      name: list.name,
      color: Color(list.color!),
    );
  }
}
