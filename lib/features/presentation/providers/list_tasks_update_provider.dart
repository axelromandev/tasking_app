import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/i18n/i18n.dart';

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

  void onIconChanged(IconData icon) {
    state = state.copyWith(icon: icon);
  }

  void onSubmit(BuildContext context) {
    if (state.title.isEmpty) {
      MyToast.show(S.dialogs.listTasksUpdate.errorEmptyName);
      return;
    }
    final newList = list.copyWith(
      title: state.title,
      icon: state.icon,
    );
    _listTasksRepository.update(newList).then((_) {
      refreshList();
      context.pop();
    });
  }
}

class _State {
  _State({
    this.title = '',
    this.icon = IconsaxOutline.folder,
  });

  final String title;
  final IconData icon;

  _State copyWith({
    String? title,
    IconData? icon,
  }) {
    return _State(
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  _State init(ListTasks list) {
    return _State(
      title: list.title,
      icon: list.icon,
    );
  }
}
