import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

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
      final now = DateTime.now();
      if (date == null) {
        return S.of(context).button_due_date;
      }
      if (date.day == now.day && date.month == now.month) {
        return S.of(context).calendar_today;
      }
      if (date.day == now.day + 1 && date.month == now.month) {
        return S.of(context).calendar_tomorrow;
      }
      if (date.year == now.year) {
        return DateFormat().add_MMMMEEEEd().format(task.dueDate!).toString();
      }
      return DateFormat().add_yMMMMEEEEd().format(task.dueDate!).toString();
    }

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
          color: task.isCompleted != null
              ? isDarkMode
                  ? Colors.white30
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
                      ? colors.primary.withOpacity(.3)
                      : colors.primary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  formatDate(),
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
