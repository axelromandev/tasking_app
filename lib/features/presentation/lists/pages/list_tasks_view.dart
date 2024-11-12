import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTasksView extends ConsumerWidget {
  const ListTasksView(this.listId, {super.key});

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(listTasksProvider(listId));

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(provider.list!.icon, color: colorPrimary),
            const Gap(12),
            Flexible(
              child: Text(
                provider.list!.title,
                style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => ListTasksOptionsModal(context, listId),
            ),
            iconSize: 20.0,
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body: (provider.pending.isEmpty && provider.completed.isEmpty)
          ? _EmptyTasks()
          : _BuildTasks(listId),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(defaultPadding),
          child: ListTile(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => TaskAddModal(
                TaskAddConfig(listId: listId),
              ),
            ),
            leading: const Icon(IconsaxOutline.add),
            title: const Text('Add a task'),
          ),
        ),
      ),
    );
  }
}

class _BuildTasks extends ConsumerWidget {
  const _BuildTasks(this.listId);

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(listTasksProvider(listId));
    final notifier = ref.read(listTasksProvider(listId).notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (provider.pending.isNotEmpty) const Gap(8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            separatorBuilder: (_, __) => const Gap(4),
            itemCount: provider.pending.length,
            itemBuilder: (_, i) {
              final Task task = provider.pending[i];
              return TaskCard(
                task: provider.pending[i],
                onTap: () {
                  ref.read(taskAccessTypeProvider.notifier).setList();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TaskPage(task.id),
                      fullscreenDialog: true,
                    ),
                  );
                },
                onDismissed: () => notifier.onDismissibleTask(task.id),
                onToggleCompleted: () => notifier.onToggleCompleted(task.id),
                onToggleImportant: () => notifier.onToggleImportant(task.id),
              );
            },
          ),
          const Gap(defaultPadding),
          if (provider.completed.isNotEmpty)
            CompletedTaskExpansion(
              margin: const EdgeInsets.only(left: defaultPadding),
              length: provider.completed.length,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (_, __) => const Gap(4),
                itemCount: provider.completed.length,
                itemBuilder: (_, i) {
                  final Task task = provider.completed[i];
                  return TaskCard(
                    task: provider.completed[i],
                    onTap: () {
                      ref.read(taskAccessTypeProvider.notifier).setList();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TaskPage(task.id),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    onDismissed: () => notifier.onDismissibleTask(task.id),
                    onToggleCompleted: () =>
                        notifier.onToggleCompleted(task.id),
                    onToggleImportant: () =>
                        notifier.onToggleImportant(task.id),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: colorPrimary.withOpacity(.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              IconsaxOutline.clipboard_tick,
              size: 38.0,
              color: colorPrimary,
            ),
          ),
          const Gap(defaultPadding),
          Text(
            S.features.lists.page.emptyTasks.title,
            style: style.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8.0),
          Text(
            S.features.lists.page.emptyTasks.subtitle,
            style: style.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
