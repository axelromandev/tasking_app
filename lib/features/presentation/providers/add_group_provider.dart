import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

final addGroupProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State());

  final textController = TextEditingController();

  final _groupRepository = ListTasksRepository();

  void onNameChanged(String value) {
    state = state.copyWith(name: value);
  }

  void onClearName() {
    textController.clear();
    state = state.copyWith(name: '');
  }

  void onIconChanged(IconData icon) {
    state = state.copyWith(icon: icon);
  }

  Future<void> onAddGroup(BuildContext context) async {
    try {
      await _groupRepository.add(state.name, state.icon).then((_) {
        Navigator.pop(context);
      });
    } catch (e) {
      Snackbar.custom('Failed to add group');
    }
  }
}

class _State {
  final bool isLoading;
  final bool isShared;
  final String name;
  final IconData icon;

  _State({
    this.isLoading = false,
    this.isShared = false,
    this.name = '',
    this.icon = BoxIcons.bx_list_ul,
  });

  _State copyWith({
    bool? isLoading,
    bool? isShared,
    String? name,
    IconData? icon,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      isShared: isShared ?? this.isShared,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }
}
