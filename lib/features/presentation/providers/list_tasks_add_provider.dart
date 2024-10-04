import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
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

  // final _listTasksRepository = ListTasksRepositoryImpl();

  final List<IconData> icons = [
    IconsaxOutline.folder,
    IconsaxOutline.home_2,
    IconsaxOutline.briefcase,
    IconsaxOutline.cloud,
    IconsaxOutline.lock,
    IconsaxOutline.star,
    IconsaxOutline.heart,
    IconsaxOutline.document_download,
    IconsaxOutline.document_upload,
    IconsaxOutline.edit,
    IconsaxOutline.search_normal,
    IconsaxOutline.setting,
    IconsaxOutline.archive,
    IconsaxOutline.document_1,
    IconsaxOutline.note,
    IconsaxOutline.clipboard_text,
    IconsaxOutline.code,
    IconsaxOutline.trend_up,
    IconsaxOutline.trend_down,
    IconsaxOutline.user,
    IconsaxOutline.shield,
    IconsaxOutline.filter,
    IconsaxOutline.trash,
    IconsaxOutline.notification,
    IconsaxOutline.chart_square,
    IconsaxOutline.refresh,
    IconsaxOutline.flag,
    IconsaxOutline.crown,
  ];

  void onNameChanged(String value) {
    state = state.copyWith(title: value.trim());
  }

  void onIconChanged(IconData icon) {
    state = state.copyWith(icon: icon);
  }

  Future<void> onSubmit(BuildContext context) async {
    if (state.title.isEmpty) {
      MyToast.show(S.modals.listTasks.errorEmptyName);
      return;
    }
    final iconEncode = IconDataUtils.encode(IconsaxOutline.info_circle);
    print(iconEncode);

    // final iconEncode = IconDataUtils.encode(state.icon);
    // await _listTasksRepository.add(state.title, iconEncode).then((list) {
    //   context.pop();
    //   refresh();
    // });
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
