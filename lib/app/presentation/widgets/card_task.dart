import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
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
    final colors = Theme.of(context).colorScheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    String formatDate() {
      final date = task.dueDate;
      if (date == null) {
        return S.of(context).button_due_date;
      }
      if (date.day == DateTime.now().day) {
        return 'Hoy';
      }
      if (date.day == DateTime.now().day + 1) {
        return 'Mañana';
      }
      return DateFormat().add_yMMMMEEEEd().format(task.dueDate!).toString();
    }

    return Card(
      color: isDarkMode ? null : Colors.white,
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
            color: colors.primary,
          ),
        ),
        title: Text(
          task.message,
          style: style.titleMedium?.copyWith(
            fontWeight: FontWeight.w300,
            color: task.isCompleted != null
                ? isDarkMode
                    ? Colors.white70
                    : Colors.black54
                : null,
          ),
        ),
        subtitle: task.dueDate != null
            ? Row(
                children: [
                  Icon(
                    BoxIcons.bx_calendar,
                    color: task.isCompleted != null
                        ? isDarkMode
                            ? Colors.white70
                            : Colors.black54
                        : null,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(),
                    style: style.bodyMedium?.copyWith(
                      color: task.isCompleted != null
                          ? isDarkMode
                              ? Colors.white70
                              : Colors.black54
                          : null,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )
            : null,
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
