import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/presentation/pages/pages.dart';
import 'package:tasking/presentation/providers/providers.dart';
import 'package:tasking/presentation/shared/shared.dart';

class ListsView extends StatelessWidget {
  const ListsView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: ListsView Implement build method.

    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listas',
          style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: _ListsTasksView(),
    );
  }
}

class _ListsTasksView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);

    final lists = provider.lists;
    final listsArchived = provider.listsArchived;

    if (lists.isEmpty) return _EmptyListTasks();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
              leading: const Icon(BoxIcons.bx_archive, size: 18),
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
