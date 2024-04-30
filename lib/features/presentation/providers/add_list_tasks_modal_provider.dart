import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../domain/domain.dart';
import 'show_list_tasks_provider.dart';

final addListTasksModalProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final refresh = ref.read(showListTasksProvider.notifier).refresh;

  return _Notifier(refresh);
});

class _Notifier extends StateNotifier<_State> {
  final Future<void> Function() refresh;

  _Notifier(this.refresh) : super(_State());

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
      Fluttertoast.showToast(
        msg: 'Please enter a list name.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    await _listTasksRepository
        .add(state.name, state.color, BoxIcons.bxs_circle)
        .then((_) {
      refresh();
      context.pop();
    });
  }
}

class _State {
  final String name;
  final Color color;
  final IconData icon;

  _State({
    this.name = '',
    this.color = Colors.amber,
    this.icon = BoxIcons.bx_list_ul,
  });

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
