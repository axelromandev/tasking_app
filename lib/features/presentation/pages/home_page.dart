import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../i18n/generated/translations.g.dart';
import '../dialogs/list_tasks_add_dialog.dart';
import '../providers/all_list_tasks_provider.dart';
import '../widgets/archived_icon_button.dart';
import '../widgets/card_list_tasks.dart';
import 'list_tasks_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.pages.home.title, style: style.bodyLarge),
        centerTitle: false,
        actions: [
          const ArchivedIconButton(),
          IconButton(
            onPressed: () => context.push(Routes.settings),
            icon: const Icon(BoxIcons.bx_cog, size: 20),
          ),
        ],
      ),
      body: _ListsTasksView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorPrimary,
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const ListTasksAddDialog(),
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

    void push(int listId) {
      final String path = ListTasksPage.routePath.replaceAll(':id', '$listId');
      context.push(path);
    }

    return ListView(
      children: [
        const Gap(defaultPadding / 2),
        if (pinnedLists.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pinnedLists.length,
            itemBuilder: (_, i) => ListTasksCard(
              onTap: () => push(pinnedLists[i].id),
              list: pinnedLists[i],
            ),
          ),
        ],
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: unpinnedLists.length,
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
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Container(
      margin: const EdgeInsets.only(top: 250.0),
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
              BoxIcons.bx_clipboard,
              size: 38.0,
              color: colorPrimary,
            ),
          ),
          const Gap(defaultPadding),
          Text(
            S.pages.home.emptyListTasks.title,
            style: style.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap(8.0),
          Text(
            S.pages.home.emptyListTasks.subtitle,
            style: style.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
