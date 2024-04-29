import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../modals/add_task_modal.dart';
import '../modals/select_group_modal.dart';
import '../modals/task_modal.dart';
import '../presentation.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final group = ref.watch(homeProvider).group;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              elevation: 0,
              builder: (_) => const SelectGroupModal(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  group?.icon?.iconData ?? BoxIcons.bx_crown,
                  color: colors.primary,
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    group?.name ?? 'Tasking',
                    style: style.titleLarge?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(BoxIcons.bx_chevron_down, color: Colors.white),
              ],
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => context.push(RoutesPath.settings),
              icon: const Icon(BoxIcons.bx_cog),
            ),
          ],
        ),
        body: _BuildTasks(),
        floatingActionButton: _AddTaskButton(),
      ),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        elevation: 0,
        isScrollControlled: true,
        builder: (_) => LayoutBuilder(builder: (context, _) {
          return AnimatedPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500, minHeight: 150),
              child: const AddTaskModal(),
            ),
          );
        }),
      ),
      backgroundColor: colors.primary,
      child: const Icon(BoxIcons.bx_plus),
    );
  }
}

class _BuildTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final provider = ref.watch(homeProvider);
    final tasks = provider.tasks;

    final listCompleted =
        tasks.where((task) => task.isCompleted != null).toList();
    listCompleted.sort((a, b) => b.isCompleted!.compareTo(a.isCompleted!));

    final listPending =
        tasks.where((task) => task.isCompleted == null).toList();

    if (tasks.isEmpty) {
      return Center(
        child: Text(S.of(context).home_empty_tasks, style: style.bodyLarge),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      children: [
        ...listPending.map((task) => _BuildTask(task)),
        if (listCompleted.isNotEmpty)
          Row(
            children: [
              TextButton.icon(
                onPressed:
                    ref.read(homeProvider.notifier).onToggleShowCompleted,
                icon: Icon(
                  provider.isShowCompleted
                      ? BoxIcons.bx_hide
                      : BoxIcons.bx_show,
                  size: 16.0,
                ),
                style: TextButton.styleFrom(
                  foregroundColor: colors.onSurface.withOpacity(.8),
                ),
                label: provider.isShowCompleted
                    ? Text(S.of(context).button_hide_completed)
                    : Text(S.of(context).button_show_completed),
              ),
              const Spacer(),
              if (provider.isShowCompleted)
                TextButton.icon(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    elevation: 0,
                    builder: (_) => Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text(
                                'Eliminar todas las tareas completadas',
                                style: style.titleLarge,
                              ),
                            ),
                            const Gap(defaultPadding),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomFilledButton(
                                    onPressed: () => Navigator.pop(context),
                                    backgroundColor: Colors.white10,
                                    foregroundColor: colors.onSurface,
                                    child: Text(S.of(context).button_cancel),
                                  ),
                                ),
                                const Gap(defaultPadding),
                                Expanded(
                                  child: CustomFilledButton(
                                    onPressed: () {
                                      ref
                                          .read(homeProvider.notifier)
                                          .onClearCompleted();
                                      Navigator.pop(context);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: colors.onSurface,
                                    child: const Text('Eliminar'),
                                  ),
                                ),
                              ],
                            ),
                            if (Platform.isAndroid) const Gap(defaultPadding),
                          ],
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(BoxIcons.bx_trash, size: 16.0),
                  label: Text(S.of(context).button_clear),
                ),
            ],
          ),
        if (provider.isShowCompleted)
          ...listCompleted.map((task) => _BuildTask(task)),
      ],
    );
  }
}

class _BuildTask extends ConsumerWidget {
  const _BuildTask(this.task);
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardTask(
      onShowDetails: () => showModalBottomSheet(
        context: context,
        elevation: 0,
        isScrollControlled: true,
        builder: (_) => TaskModal(task),
      ),
      onCheckTask: () => ref.read(homeProvider.notifier).onToggleCheck(task),
      task: task,
    );
  }
}
