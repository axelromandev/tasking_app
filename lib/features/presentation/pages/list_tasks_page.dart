import 'package:ficonsax/ficonsax.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
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

    final list = ref.watch(listTasksProvider(listId));

    if (list.id == 0) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          iconSize: 30.0,
          icon: const Icon(IconsaxOutline.arrow_left_2, size: 20),
        ),
        title: GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => ListTasksUpdateModal(list),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ColorIndicator(
                  color: Colors.amber,
                  width: 18,
                  height: 18,
                ),
                const Gap(defaultPadding),
                Flexible(child: Text(list.title, style: style.bodyLarge)),
                const Gap(defaultPadding),
                const Icon(IconsaxOutline.edit, size: 18),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => ListTasksOptionsModal(context, list.id),
            ),
            iconSize: 18.0,
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body:
          list.tasks.isEmpty ? _EmptyTasks() : _BuildTasks(list.tasks.toList()),
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
            leading: const Icon(IconsaxOutline.add),
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
    final style = Theme.of(context).textTheme;

    final pendingTasks =
        tasks.where((task) => task.completedAt == null).toList();
    pendingTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final completedTasks =
        tasks.where((task) => task.completedAt != null).toList();
    completedTasks.sort((a, b) => a.completedAt!.compareTo(b.completedAt!));

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: pendingTasks.length,
          itemBuilder: (context, index) {
            final task = pendingTasks[index];
            return TaskCard(task);
          },
        ),
        if (completedTasks.isNotEmpty) ...[
          ExpansionTile(
            initiallyExpanded: true,
            dense: true,
            shape: const RoundedRectangleBorder(),
            collapsedShape: const RoundedRectangleBorder(),
            iconColor: Colors.white60,
            collapsedIconColor: Colors.white60,
            title: Row(
              children: [
                Text(
                  S.pages.listTasks.completed.title,
                  style: style.bodySmall?.copyWith(color: Colors.white70),
                ),
                const Spacer(),
                Text(
                  '${completedTasks.length}',
                  style: style.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return TaskCard(task);
                },
              ),
            ],
          ),
        ],
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
