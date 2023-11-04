import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

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

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onShowDetails,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minLeadingWidth: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: onCheckTask,
          icon: Icon(
            task.isCompleted != null
                ? BoxIcons.bx_check_circle
                : BoxIcons.bx_circle,
            color: task.isCompleted != null
                ? isDarkMode
                    ? Colors.white70
                    : Colors.black54
                : dueDateColor(task.dueDate),
          ),
        ),
        title: Text(
          task.message,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: style.titleMedium?.copyWith(
            fontWeight: FontWeight.w300,
            color: task.isCompleted != null
                ? isDarkMode
                    ? Colors.white70
                    : Colors.black54
                : dueDateColor(task.dueDate),
          ),
        ),
        trailing: Visibility(
          visible: task.reminder != null,
          child: Icon(
            BoxIcons.bx_bell,
            color: dueDateColor(task.dueDate),
          ),
        ),
      ),
    );
  }
}
