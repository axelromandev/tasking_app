import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../app.dart';

final editGroupProvider = StateNotifierProvider.family
    .autoDispose<_Notifier, _State, ListTasks>((ref, group) {
  final groupIdSelected = ref.read(homeProvider).group!.id;
  final onSelectGroup = ref.read(homeProvider.notifier).onSelectGroup;

  return _Notifier(
    group: group,
    groupIdSelected: groupIdSelected,
    onSelectGroup: onSelectGroup,
  );
});

class _Notifier extends StateNotifier<_State> {
  final ListTasks group;
  final int groupIdSelected;
  final void Function(ListTasks) onSelectGroup;

  _Notifier({
    required this.group,
    required this.groupIdSelected,
    required this.onSelectGroup,
  }) : super(_State()) {
    textController.text = group.name;
    state = state.copyWith(
      name: group.name,
      icon: group.icon!.iconData,
    );
  }

  final textController = TextEditingController();

  final _groupRepository = GroupRepository();

  void onNameChanged(String value) {
    state = state.copyWith(name: value);
  }

  void onClearName() {
    textController.clear();
    state = state.copyWith(name: '');
  }

  Future<void> onIconChanged(IconData icon) async {
    state = state.copyWith(icon: icon);
  }

  Future<void> onUpdateGroup(BuildContext context) async {
    try {
      group.icon = ListIconData(
        codePoint: state.icon.codePoint,
        fontFamily: state.icon.fontFamily,
        fontPackage: state.icon.fontPackage,
      );
      group.name = state.name;
      await _groupRepository.update(group).then((_) {
        _onSelectGroup();
        Navigator.pop(context);
      });
    } catch (e) {
      Snackbar.custom('Failed to add group');
    }
  }

  void _onSelectGroup() {
    if (groupIdSelected != group.id) return;
    onSelectGroup(group);
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
