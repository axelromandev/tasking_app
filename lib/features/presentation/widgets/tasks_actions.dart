import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../modals/list_tasks_options_modal.dart';
import '../providers/list_tasks_provider.dart';
import '../providers/select_list_id_provider.dart';

class TasksActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listTasksProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            ref.read(selectListIdProvider.notifier).change(0);
          },
          iconSize: 18.0,
          color: ref.watch(colorThemeProvider),
          icon: Icon(
            ref.watch(listTasksProvider) == null
                ? BoxIcons.bxs_grid_alt
                : BoxIcons.bx_grid_alt,
          ),
        ),
        if (list != null)
          IconButton(
            onPressed: ref.read(listTasksProvider.notifier).onPinned,
            color: ref.watch(colorThemeProvider),
            icon: Icon(
              list.isPinned ? BoxIcons.bxs_pin : BoxIcons.bx_pin,
              size: 18,
            ),
          ),
        if (list != null)
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => const ListTasksOptionsModal(),
            ),
            iconSize: 18.0,
            color: ref.watch(colorThemeProvider),
            icon: const Icon(BoxIcons.bx_dots_vertical_rounded),
          ),
      ],
    );
  }
}
