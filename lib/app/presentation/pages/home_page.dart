import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Row(
            children: [
              Text('Personal', style: style.titleLarge),
              const SizedBox(width: defaultPadding / 2),
              const Icon(BoxIcons.bx_chevron_down),
            ],
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
        bottomNavigationBar: const AddTaskField(),
      ),
    );
  }
}

class _BuildTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(homeProvider).tasks;

    final listCompleted =
        tasks.where((task) => task.isCompleted != null).toList();
    listCompleted.sort((a, b) => b.isCompleted!.compareTo(a.isCompleted!));

    final listPending =
        tasks.where((task) => task.isCompleted == null).toList();
    listPending.sort((a, b) => b.createAt!.compareTo(a.createAt!));

    final style = Theme.of(context).textTheme;

    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(HeroIcons.check),
            Text(S.of(context).home_empty_tasks, style: style.bodyLarge),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        ...listPending.map((task) => _BuildTask(task)).toList(),
        if (listCompleted.isNotEmpty)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (listPending.isNotEmpty)
                const SizedBox(height: defaultPadding * 2),
              Row(
                children: [
                  const Icon(
                    BoxIcons.bx_check_circle,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(S.of(context).home_completed,
                      style: style.titleMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      )),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ...listCompleted.map((task) => _BuildTask(task)).toList(),
      ],
    );
  }
}

class _BuildTask extends ConsumerWidget {
  final Task task;
  const _BuildTask(this.task);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardTask(
      onShowDetails: () {
        final routePath = RoutesPath.task.replaceAll(':id', '${task.id}');
        context.push(routePath);
      },
      onCheckTask: () => ref.read(homeProvider.notifier).onToggleCheck(task),
      task: task,
    );
  }
}
