import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.onTap,
    required this.onDismissed,
    required this.onToggleCompleted,
    required this.onToggleImportant,
    required this.task,
    this.currentAccess = TaskAccessType.list,
    super.key,
  });

  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final VoidCallback onToggleCompleted;
  final VoidCallback onToggleImportant;
  final Task task;
  final TaskAccessType currentAccess;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final bool isCompleted = (task.completedAt != null);

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: defaultPadding),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              IconsaxOutline.trash,
              size: 18,
              color: Colors.white,
            ),
            const Gap(8.0),
            Text(S.common.buttons.delete, style: style.bodyLarge),
          ],
        ),
      ),
      onDismissed: (_) => onDismissed(),
      confirmDismiss: (_) async => await showDialog(
        context: context,
        builder: (_) => TaskDeleteDialog(),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        tileColor: AppColors.card,
        iconColor: isCompleted ? Colors.white70 : Colors.white,
        leading: IconButton(
          onPressed: onToggleCompleted,
          icon: Icon(
            isCompleted ? IconsaxOutline.tick_circle : IconsaxOutline.record,
          ),
        ),
        trailing: IconButton(
          onPressed: onToggleImportant,
          iconSize: 20,
          icon: Icon(
            task.isImportant ? IconsaxBold.star_1 : IconsaxOutline.star,
          ),
        ),
        title: Text(
          task.title,
          style: isCompleted
              ? style.bodyLarge?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.grey,
                  color: Colors.grey,
                )
              : style.bodyLarge,
        ),
        subtitle: (task.steps.isNotEmpty ||
                task.dateline != null ||
                task.reminder != null ||
                task.notes.isNotEmpty)
            ? _TaskDetails(
                dateline: task.dateline,
                reminder: task.reminder,
                notes: task.notes,
                isCompleted: isCompleted,
                steps: task.steps,
              )
            : null,
      ),
    );
  }
}

class _TaskDetails extends StatelessWidget {
  const _TaskDetails({
    required this.dateline,
    required this.reminder,
    required this.notes,
    required this.isCompleted,
    required this.steps,
  });

  final DateTime? dateline;
  final DateTime? reminder;
  final String notes;
  final bool isCompleted;
  final List<StepTask> steps;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (steps.isNotEmpty)
          Text(
            '${steps.where((step) => step.completedAt != null).length} de ${steps.length}',
            style: style.bodySmall,
          ),
        if (dateline != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (steps.isNotEmpty) const Text(' ・ '),
              const Icon(
                IconsaxOutline.calendar_2,
                size: 14,
              ),
              const Gap(4.0),
              Flexible(
                child: Text(
                  HumanFormat.datetime(dateline),
                  style: isCompleted
                      ? style.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                          color: Colors.grey,
                        )
                      : style.bodySmall,
                ),
              ),
            ],
          ),
        if (reminder != null || notes.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dateline != null) const Text(' ・ '),
              if (reminder != null)
                const Icon(
                  IconsaxOutline.notification,
                  size: 14,
                ),
              const Gap(4.0),
              if (notes.isNotEmpty)
                const Icon(
                  IconsaxOutline.note,
                  size: 14,
                ),
            ],
          ),
      ],
    );
  }
}
