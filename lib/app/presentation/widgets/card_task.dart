import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/domain/domain.dart';
import 'package:tasking/core/core.dart';

class CardTask extends StatelessWidget {
  final VoidCallback onShowDetails;
  final VoidCallback onCheckTask;
  final Task task;

  const CardTask({
    required this.onShowDetails,
    required this.onCheckTask,
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onShowDetails,
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: onCheckTask,
        icon: Icon(
          task.isCompleted != null
              ? BoxIcons.bx_check_circle
              : BoxIcons.bx_circle,
          color: task.isCompleted != null
              ? colors.primary.withOpacity(.6)
              : colors.primary,
        ),
      ),
      visualDensity: VisualDensity.compact,
      title: Text(
        task.message,
        style: style.titleMedium?.copyWith(
          fontWeight: FontWeight.w300,
          color: task.isCompleted != null ? Colors.white30 : Colors.white,
        ),
      ),
      subtitle: task.dueDate?.date != null
          ? Row(
              children: [
                Icon(
                  (task.dueDate?.isReminder ?? false)
                      ? BoxIcons.bx_bell
                      : BoxIcons.bx_calendar,
                  color: task.isCompleted != null
                      ? colors.primary.withOpacity(.3)
                      : colors.primary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  formatDate(task.dueDate?.date, task.dueDate!.isReminder),
                  style: style.bodyMedium?.copyWith(
                    color: task.isCompleted != null
                        ? colors.primary.withOpacity(.3)
                        : colors.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
