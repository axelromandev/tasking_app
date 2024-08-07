import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../i18n/generated/translations.g.dart';
import '../modals/list_tasks_add_modal.dart';
import '../providers/all_list_tasks_provider.dart';
import '../widgets/card_list_tasks.dart';
import 'list_tasks_page.dart';

class AllListTasksPage extends ConsumerWidget {
  const AllListTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 1.5,
            color: Colors.white.withOpacity(.06),
          ),
          Expanded(
            child: _ListsTasksView(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => const ListTasksAddModal(),
        ),
        child: const Icon(BoxIcons.bx_plus),
      ),
    );
  }
}

class _ListsTasksView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(allListTasksProvider).lists;

    if (lists.isEmpty) {
      return _EmptyListTasks();
    }

    final pinnedLists = lists.where((list) => list.pinned).toList();
    final unpinnedLists = lists.where((list) => !list.pinned).toList();

    final style = Theme.of(context).textTheme;

    void push(int listId) {
      HapticFeedback.mediumImpact();
      final String path = ListTasksPage.routePath.replaceAll(':id', '$listId');
      context.push(path);
    }

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
            title: Text(
              'Pinned',
              style: style.bodySmall?.copyWith(
                color: Colors.white38,
              ),
            ),
          ),
          MasonryGridView.count(
            itemCount: pinnedLists.length,
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => ListTasksCard(
              onTap: () => push(pinnedLists[i].id),
              list: pinnedLists[i],
            ),
          ),
          const Gap(defaultPadding),
        ],
        MasonryGridView.count(
          itemCount: unpinnedLists.length,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(defaultPadding),
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) => ListTasksCard(
            onTap: () => push(unpinnedLists[i].id),
            list: unpinnedLists[i],
          ),
        ),
      ],
    );
  }
}

class _EmptyListTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final style = Theme.of(context).textTheme;

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
                  color: colorPrimary.withOpacity(.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  BoxIcons.bxs_inbox,
                  size: 38.0,
                  color: colorPrimary,
                ),
              ),
              const Gap(defaultPadding),
              Text(
                S.pages.listTasks.emptyListTasks.title,
                style: style.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8.0),
              Text(
                S.pages.listTasks.emptyListTasks.subtitle,
                style: style.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
