import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../domain/domain.dart';
import '../modals/list_tasks_update_modal.dart';
import '../providers/list_tasks_provider.dart';
import '../widgets/card_task.dart';

class BuildListTasks extends ConsumerWidget {
  const BuildListTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listTasks = ref.watch(listTasksProvider);

    if (listTasks == null) {
      return const SizedBox();
    }

    final style = Theme.of(context).textTheme;

    return ListView(
      children: [
        ListTile(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => ListTasksUpdateModal(listTasks),
          ),
          shape: const RoundedRectangleBorder(),
          leading: Icon(
            listTasks.icon?.iconData ?? BoxIcons.bxs_circle,
            color: Color(listTasks.color ?? 0xFF000000),
            size: 18,
          ),
          title: Text(listTasks.name, style: style.bodyLarge),
        ),
        if (listTasks.tasks.isEmpty)
          _EmptyTasks()
        else
          _BuildTasks(listTasks.tasks.toList()),
      ],
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
    pendingTasks.sort((a, b) => a.position.compareTo(b.position));

    final completedTasks = tasks.where((task) => task.completed).toList();
    completedTasks.sort((a, b) => a.position.compareTo(b.position));

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
          ListTile(
            visualDensity: VisualDensity.compact,
            shape: const RoundedRectangleBorder(),
            title: Text(
              'Completed',
              style: style.bodySmall?.copyWith(color: Colors.white70),
            ),
          ),
        ],
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
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 200.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              BoxIcons.bx_task,
              size: 38.0,
              color: Colors.white70,
            ),
          ),
          const Gap(defaultPadding),
          Text(
            'There is no task.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Gap(8.0),
          Text(
            'Press + to add the task',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }
}
