import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../providers/select_list_id_provider.dart';
import '../providers/show_list_tasks_provider.dart';

class TasksDrawer extends ConsumerWidget {
  const TasksDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final listId = ref.watch(selectListIdProvider);
    final lists = ref.watch(showListTasksProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ListTitleShowAll(current: listId),
            const Divider(),
            ListTile(
              visualDensity: VisualDensity.compact,
              leading: const Icon(
                BoxIcons.bx_list_ul,
                size: 16,
                color: Colors.white70,
              ),
              title: Text(
                'LIST',
                style: style.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lists.length,
              itemBuilder: (context, index) {
                final list = lists[index];
                return ListTile(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.read(selectListIdProvider.notifier).change(list.id);
                    context.pop();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  tileColor:
                      listId == list.id ? Colors.white.withOpacity(.06) : null,
                  visualDensity: VisualDensity.compact,
                  leading: Icon(
                    list.icon?.iconData ?? BoxIcons.bxs_circle,
                    size: 18,
                    color: Color(list.color ?? 0xFF000000),
                  ),
                  title: Text(list.name),
                  trailing: list.tasks.isNotEmpty
                      ? Text(
                          list.tasks.length.toString(),
                          style: style.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        )
                      : null,
                );
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              onTap: () => context.push(Routes.settings.path),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              visualDensity: VisualDensity.compact,
              leading: const Icon(BoxIcons.bxs_cog, size: 20),
              title: Text('Settings', style: style.bodyLarge),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}

class _ListTitleShowAll extends ConsumerWidget {
  const _ListTitleShowAll({
    required this.current,
  });

  final int current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return ListTile(
      onTap: () {
        HapticFeedback.mediumImpact();
        ref.read(selectListIdProvider.notifier).change(0);
        context.pop();
      },
      tileColor: current == 0 ? Colors.white.withOpacity(.06) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      visualDensity: VisualDensity.compact,
      leading: const Icon(BoxIcons.bxs_inbox, size: 18),
      title: Text('ALL', style: style.bodyMedium),
    );
  }
}
