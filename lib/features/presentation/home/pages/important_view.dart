import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ImportantView extends ConsumerWidget {
  const ImportantView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(importantProvider);

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(IconsaxOutline.star, color: colorPrimary),
            const Gap(12),
            Text(
              S.features.home.important.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => _MoreOptions(),
            ),
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body: _TasksBuilder(),
    );
  }
}

class _MoreOptions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(importantProvider);
    final notifier = ref.read(importantProvider.notifier);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: defaultPadding,
          horizontal: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                onTap: notifier.toggleShowCompleted,
                leading: provider.showCompleted
                    ? const Icon(IconsaxOutline.tick_circle)
                    : const Icon(IconsaxOutline.record),
                title: provider.showCompleted
                    ? Text(S.features.home.important.moreOptions.hideCompleted)
                    : Text(S.features.home.important.moreOptions.showCompleted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TasksBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.read(importantProvider).tasks;

    if (tasks.isEmpty) {
      return const EmptyImportantTasks();
    }

    final notifier = ref.read(importantProvider.notifier);

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      separatorBuilder: (_, __) => const Gap(8),
      itemCount: tasks.length,
      itemBuilder: (_, i) {
        final Task task = tasks[i];
        return TaskCard(
          task: task,
          onDismissed: () => notifier.delete(task.id),
          onToggleCompleted: () => notifier.toggleCompleted(task),
          onToggleImportant: () => notifier.uncheckImportant(task.id),
        );
      },
    );
  }
}
