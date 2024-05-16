import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../providers/select_list_id_provider.dart';
import '../providers/show_list_tasks_provider.dart';
import '../widgets/card_list_tasks.dart';

class BuildAllListTasks extends ConsumerWidget {
  const BuildAllListTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(showListTasksProvider);

    if (lists.isEmpty) {
      return _EmptyListTasks();
    }

    final pinnedLists = lists.where((list) => list.isPinned).toList();
    final unpinnedLists = lists.where((list) => !list.isPinned).toList();

    final style = Theme.of(context).textTheme;

    return ListView(
      children: [
        if (pinnedLists.isNotEmpty) ...[
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: const Icon(
              BoxIcons.bxs_pin,
              size: 16,
              color: Colors.white38,
            ),
            minLeadingWidth: 0,
            title: Text('Pinned',
                style: style.bodySmall?.copyWith(
                  color: Colors.white38,
                )),
          ),
          MasonryGridView.count(
            itemCount: pinnedLists.length,
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final list = pinnedLists[index];
              return ListTasksCard(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  ref.read(selectListIdProvider.notifier).change(list.id);
                },
                list: list,
              );
            },
          ),
          const Gap(defaultPadding),
          if (unpinnedLists.isNotEmpty)
            Container(
              height: 1.5,
              color: Colors.white.withOpacity(.06),
            ),
        ],
        MasonryGridView.count(
          itemCount: unpinnedLists.length,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(defaultPadding),
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final list = unpinnedLists[index];
            return ListTasksCard(
              onTap: () {
                HapticFeedback.mediumImpact();
                ref.read(selectListIdProvider.notifier).change(list.id);
              },
              list: list,
            );
          },
        ),
      ],
    );
  }
}

class _EmptyListTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          height: 1.5,
          color: Colors.white.withOpacity(.06),
        ),
        Container(
          margin: const EdgeInsets.only(top: 200.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  BoxIcons.bxs_inbox,
                  size: 38.0,
                  color: colors.primary,
                ),
              ),
              const Gap(defaultPadding),
              Text('There is no list.',
                  style: style.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
              const Gap(8.0),
              Text('Press + to add the list',
                  style: style.bodyMedium?.copyWith(
                    color: Colors.white70,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
