import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../../i18n/generated/translations.g.dart';
import '../../domain/domain.dart';
import 'all_list_tasks_provider.dart';

final listTasksAddModalProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final refresh = ref.read(allListTasksProvider.notifier).refreshAll;

  return _Notifier(refresh);
});

class _Notifier extends StateNotifier<_State> {
  _Notifier(this.refresh) : super(_State());

  final Future<void> Function() refresh;

  final expansionTileController = ExpansionTileController();
  final _listTasksRepository = ListTasksRepository();

  void onNameChanged(String value) {
    state = state.copyWith(name: value);
  }

  Future<void> onColorChanged(Color color) async {
    state = state.copyWith(color: color);
    await Future.delayed(const Duration(milliseconds: 100));
    expansionTileController.collapse();
  }

  void onIconChanged(IconData icon) {
    state = state.copyWith(icon: icon);
  }

  Future<void> onSubmit(BuildContext context) async {
    if (state.name.trim().isEmpty) {
      MyToast.show(S.common.modals.listTasksAdd.errorEmptyName);
      return;
    }
    await _listTasksRepository.add(state.name, state.color).then((list) {
      context.pop();
      refresh();
    });
  }
}

class _State {
  _State({
    this.name = '',
    this.color = Colors.amber,
    this.icon = BoxIcons.bx_list_ul,
  });
  final String name;
  final Color color;
  final IconData icon;

  _State copyWith({
    String? name,
    Color? color,
    IconData? icon,
  }) {
    return _State(
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }
}
