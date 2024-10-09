import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/pages/pages.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTasksPage extends ConsumerWidget {
  const ListTasksPage(this.listId, {super.key});

  static String routePath = '/list/:id';

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final list = ref.watch(listTasksProvider(listId));

    if (list.id == 0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(IconsaxOutline.arrow_left_2, size: 20),
              ),
            ),
            const Gap(defaultPadding),
            Icon(list.icon, color: colorPrimary),
            const Gap(12),
            Flexible(
              child: Text(
                list.title,
                style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ListTasksUpdatePage(list)),
            ),
            iconSize: 20.0,
            icon: const Icon(IconsaxOutline.edit),
          ),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => ListTasksOptionsModal(context, list.id),
            ),
            iconSize: 20.0,
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body: (list.tasks.isEmpty)
          ? _EmptyTasks()
          : _BuildTasks(list.tasks.toList()),
      bottomNavigationBar: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(defaultPadding),
          child: ListTile(
            visualDensity: VisualDensity.compact,
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => TaskAddModal(list.id),
            ),
            title: Text(S.modals.taskAdd.placeholder),
          ),
        ),
      ),
    );
  }
}

class _BuildTasks extends StatelessWidget {
  const _BuildTasks(this.tasks);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final pendingTasks =
        tasks.where((task) => task.completedAt == null).toList();
    pendingTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final completedTasks =
        tasks.where((task) => task.completedAt != null).toList();
    completedTasks.sort((a, b) => a.completedAt!.compareTo(b.completedAt!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          separatorBuilder: (_, __) => const Gap(8),
          itemCount: pendingTasks.length,
          itemBuilder: (context, index) {
            final task = pendingTasks[index];
            return TaskCard(task);
          },
        ),
        const Gap(defaultPadding),
        if (completedTasks.isNotEmpty)
          CompletedTaskExpansion(
            margin: const EdgeInsets.only(left: defaultPadding),
            length: completedTasks.length,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return TaskCard(task);
              },
            ),
          ),
      ],
    );
  }
}

class _EmptyTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              IconsaxOutline.task,
              size: 38.0,
              color: colorPrimary,
            ),
          ),
          const Gap(defaultPadding),
          Text(
            S.pages.listTasks.emptyTasks.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Gap(8.0),
          Text(
            S.pages.listTasks.emptyTasks.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }
}
