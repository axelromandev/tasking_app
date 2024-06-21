import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../domain/domain.dart';
import '../pages/task_page.dart';
import '../providers/task_provider.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(taskProvider(task));
    final notifier = ref.read(taskProvider(task).notifier);

    final List<SubTask> subtasks = task.subtasks.toList();
    final List<SubTask> completedSubtasks =
        subtasks.where((subtask) => subtask.completed).toList();

    final bool isCompleted = provider.completed;

    return ListTile(
      key: Key('${provider.id}'),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TaskPage(task),
          fullscreenDialog: true,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      iconColor: isCompleted ? Colors.white70 : Colors.white,
      shape: const RoundedRectangleBorder(),
      leading: IconButton(
        onPressed: notifier.onToggleCompletedStatus,
        icon: Icon(
          isCompleted ? BoxIcons.bx_check : BoxIcons.bx_circle,
          size: 18,
        ),
      ),
      title: Text(
        provider.message,
        style: isCompleted
            ? style.bodyMedium?.copyWith(color: Colors.white70)
            : style.bodyLarge,
      ),
      subtitle: (provider.hasNote && task.subtasks.isNotEmpty)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      BoxIcons.bx_file,
                      size: 12,
                      color: isCompleted ? Colors.white70 : Colors.white,
                    ),
                    const Gap(4.0),
                    Text(
                      task.note!,
                      style: style.bodySmall?.copyWith(
                        color: isCompleted ? Colors.white70 : Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      BoxIcons.bx_list_ol,
                      size: 12,
                      color: isCompleted ? Colors.white70 : Colors.white,
                    ),
                    const Gap(4.0),
                    Text(
                      '${completedSubtasks.length}/${subtasks.length}',
                      style: style.bodySmall?.copyWith(
                        color: isCompleted ? Colors.white70 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : null,
      trailing: isCompleted
          ? IconButton(
              onPressed: notifier.onDeleteCompleted,
              icon: const Icon(BoxIcons.bx_x, size: 18),
            )
          : null,
    );
  }
}
