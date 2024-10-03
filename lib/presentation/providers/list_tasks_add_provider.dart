import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/data/data.dart';
import 'package:tasking/i18n/generated/translations.g.dart';
import 'package:tasking/presentation/providers/providers.dart';

final listTasksAddProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final refresh = ref.read(homeProvider.notifier).refreshAll;

  return _Notifier(refresh);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(this.refresh) : super(_State()) {
    focusNode.requestFocus();
  }

  final Future<void> Function() refresh;
  final focusNode = FocusNode();

  final _listTasksRepository = ListTasksRepositoryImpl();

  void onNameChanged(String value) {
    state = state.copyWith(title: value.trim());
  }

  void onColorChanged(Color color) {
    state = state.copyWith(color: color);
  }

  Future<void> onSubmit(BuildContext context) async {
    if (state.title.isEmpty) {
      MyToast.show(S.modals.listTasks.errorEmptyName);
      return;
    }
    await _listTasksRepository.add(state.title, state.color).then((list) {
      context.pop();
      refresh();
    });
  }
}

class _State {
  _State({
    this.title = '',
    this.color = const Color(0xffffc107),
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
}
