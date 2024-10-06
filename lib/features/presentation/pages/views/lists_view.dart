import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/pages/pages.dart';
import 'package:tasking/features/presentation/providers/lists_provider.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ListsView extends ConsumerWidget {
  const ListsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: ListsView Implement build method.

    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);
    final provider = ref.watch(listsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(IconsaxOutline.folder_2, color: colorPrimary),
            const Gap(12),
            Text(
              'Listas',
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () => showModalBottomSheet(
              context: context,
              useSafeArea: true,
              isScrollControlled: true,
              builder: (_) => const ListTasksAddModal(),
            ),
            icon: const Icon(IconsaxOutline.add),
            label: const Text('Nueva lista'),
          ),
          const Gap(defaultPadding),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _ListsTasksView(),
    );
  }
}

class _ListsTasksView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(listsProvider);

    final lists = provider.lists;
    final listsArchived = provider.listsArchived;

    if (lists.isEmpty) return _EmptyListTasks();

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 8),
          separatorBuilder: (_, __) => const Gap(6),
          itemCount: lists.length,
          itemBuilder: (_, i) => ListTasksCard(
            onTap: () => context.push(
              ListTasksPage.routePath.replaceAll(':id', '${lists[i].id}'),
            ),
            list: lists[i],
          ),
        ),
        if (listsArchived.isNotEmpty)
          Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (_) => const ArchivedListTasksModal(),
              ),
              leading: const Icon(IconsaxOutline.archive, size: 18),
              title: Text(S.dialogs.listTasksArchived.title),
              trailing: Text('${listsArchived.length}'),
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
              IconsaxOutline.folder_2,
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
