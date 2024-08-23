import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/dialogs/dialogs.dart';
import 'package:tasking/features/presentation/modals/modals.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/widgets/widgets.dart';
import 'package:tasking/i18n/generated/translations.g.dart';

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
        body: CircularProgressIndicator(),
      );
    }

    final color = Color(list.color ?? 0xFF000000);

    final notifier = ref.read(listTasksProvider(listId).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          iconSize: 30.0,
          icon: const Icon(BoxIcons.bx_chevron_left),
        ),
        actions: [
          IconButton(
            onPressed: () => notifier.onArchived(context),
            color: color,
            iconSize: 18.0,
            icon: const Icon(BoxIcons.bx_archive_in),
          ),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => ListTasksOptionsModal(context, list.id),
            ),
            color: color,
            iconSize: 18.0,
            icon: const Icon(BoxIcons.bx_dots_vertical_rounded),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (_) => ListTasksUpdateDialog(list: list),
            ),
            shape: const RoundedRectangleBorder(),
            leading: Icon(
              BoxIcons.bxs_circle,
              color: Color(list.color ?? 0xFF000000),
              size: 18,
            ),
            title: Text(list.title, style: style.bodyLarge),
          ),
          if (list.tasks.isEmpty)
            _EmptyTasks(list.id)
          else
            _BuildTasks(list.tasks.toList()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              backgroundColor: color,
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => TaskAddModal(list.id),
              ),
              child: const Icon(BoxIcons.bx_plus),
            )
          : null,
      bottomNavigationBar: Platform.isIOS
          ? Container(
              color: AppColors.card,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SafeArea(
                child: ListTile(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => TaskAddModal(list.id),
                  ),
                  leading: const Icon(BoxIcons.bx_plus),
                  title: Text(S.common.modals.taskAdd.placeholder),
                ),
              ),
            )
          : null,
    );
  }
}

class _BuildTasks extends StatelessWidget {
  const _BuildTasks(this.tasks);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final pendingTasks = tasks.where((task) => !task.completed).toList();
    pendingTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final completedTasks = tasks.where((task) => task.completed).toList();
    completedTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return Column(
      mainAxisSize: MainAxisSize.min,
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
  const _EmptyTasks(this.listId);

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listTasksProvider(listId));

    final color = Color(list.color ?? 0xFF000000);

    return Container(
      margin: const EdgeInsets.only(top: 200.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: color.withOpacity(.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              BoxIcons.bx_task,
              size: 38.0,
              color: color,
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
