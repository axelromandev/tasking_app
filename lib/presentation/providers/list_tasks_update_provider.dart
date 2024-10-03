import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/data/data.dart';
import 'package:tasking/domain/domain.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/presentation/providers/providers.dart';

final listTasksUpdateProvider = StateNotifierProvider.family
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

  final _listTasksRepository = ListTasksRepositoryImpl();

  void onNameChanged(String value) {
    state = state.copyWith(title: value.trim());
  }

  void onColorChanged(Color value) {
    state = state.copyWith(color: value);
  }

  void onSubmit(BuildContext context) {
    if (state.title.isEmpty) {
      MyToast.show(S.dialogs.listTasksUpdate.errorEmptyName);
      return;
    }

    _listTasksRepository.update(list.id, state.title, state.color).then((_) {
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
      color: list.color,
    );
  }
}
