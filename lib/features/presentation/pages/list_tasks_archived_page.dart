import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../i18n/generated/translations.g.dart';
import '../providers/all_list_tasks_provider.dart';
import '../widgets/card_list_tasks.dart';
import 'list_tasks_page.dart';

class ListTasksArchivedPage extends ConsumerWidget {
  const ListTasksArchivedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(allListTasksProvider).listsArchived;

    if (lists.isEmpty) {
      return _EmptyListTasks();
    }

    void push(int listId) {
      HapticFeedback.mediumImpact();
      final String path = ListTasksPage.routePath.replaceAll(':id', '$listId');
      context.push(path);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 1.5,
            color: Colors.white.withOpacity(.06),
          ),
          MasonryGridView.count(
            itemCount: lists.length,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(defaultPadding),
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => ListTasksCard(
              onTap: () => push(lists[i].id),
              list: lists[i],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyListTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.5,
            color: Colors.white.withOpacity(.06),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: colorPrimary.withOpacity(.06),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    BoxIcons.bx_archive,
                    size: 38.0,
                    color: colorPrimary,
                  ),
                ),
                const Gap(defaultPadding),
                Text(
                  S.pages.listTasks.emptyArchived.title,
                  style: style.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8.0),
                Text(
                  S.pages.listTasks.emptyArchived.subtitle,
                  style: style.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
