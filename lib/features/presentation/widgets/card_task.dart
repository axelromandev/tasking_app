import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../domain/domain.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final subtasks = task.subtasks.toList();

    final completedSubtasks =
        subtasks.where((subtask) => subtask.completed).toList();

    return ListTile(
      onTap: () {
        print('tap');
      },
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      iconColor: task.completed ? Colors.white70 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      leading: IconButton(
        onPressed: () {
          print('unmark');
        },
        icon: Icon(
          task.completed ? BoxIcons.bx_check : BoxIcons.bx_circle,
          size: 18,
        ),
      ),
      title: Text(
        task.message,
        style: task.completed
            ? style.bodyMedium?.copyWith(color: Colors.white70)
            : style.bodyLarge,
      ),
      subtitle: (task.hasNote && task.subtasks.isNotEmpty)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      BoxIcons.bx_file,
                      size: 12,
                      color: task.completed ? Colors.white70 : Colors.white,
                    ),
                    const Gap(4.0),
                    Text(task.note!,
                        style: style.bodySmall?.copyWith(
                          color: task.completed ? Colors.white70 : Colors.white,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      BoxIcons.bx_list_ol,
                      size: 12,
                      color: task.completed ? Colors.white70 : Colors.white,
                    ),
                    const Gap(4.0),
                    Text('${completedSubtasks.length}/${subtasks.length}',
                        style: style.bodySmall?.copyWith(
                          color: task.completed ? Colors.white70 : Colors.white,
                        )),
                  ],
                ),
              ],
            )
          : null,
      trailing: task.completed
          ? IconButton(
              onPressed: () {
                print('delete');
              },
              icon: const Icon(BoxIcons.bx_x, size: 18),
            )
          : null,
    );
  }
}
