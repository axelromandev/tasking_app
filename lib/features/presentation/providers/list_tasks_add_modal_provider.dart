import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import 'select_list_id_provider.dart';

final listTasksAddModalProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final changeListId = ref.read(selectListIdProvider.notifier).change;

  return _Notifier(
    changeListId: changeListId,
  );
});

class _Notifier extends StateNotifier<_State> {
  _Notifier({
    required this.changeListId,
  }) : super(_State());

  final void Function(int) changeListId;

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
      MyToast.show(S.modals.listTasksAdd.errorEmptyName);
      return;
    }
    await _listTasksRepository
        .add(state.name, state.color, BoxIcons.bxs_circle)
        .then((list) {
      context.pop();
      changeListId(list.id);
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
