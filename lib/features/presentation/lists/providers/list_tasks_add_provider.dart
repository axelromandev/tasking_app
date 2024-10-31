import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/i18n/generated/translations.g.dart';

final listTasksAddProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final refresh = ref.read(listsProvider.notifier).refresh;

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

  void onIconChanged(IconData icon) {
    state = state.copyWith(icon: icon);
  }

  Future<void> onSubmit(BuildContext context) async {
    if (state.title.isEmpty) {
      MyToast.show(S.features.lists.forms.errorEmptyName);
      return;
    }
    final newList = ListTasks.create(
      title: state.title,
      icon: state.icon,
      createdAt: DateTime.now(),
    );
    await _listTasksRepository.add(newList).then((list) {
      context.pop();
      refresh();
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
}
