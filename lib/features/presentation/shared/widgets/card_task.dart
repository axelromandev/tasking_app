import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.onDismissed,
    required this.onToggleCompleted,
    required this.onToggleImportant,
    required this.task,
    super.key,
  });

  final VoidCallback onDismissed;
  final VoidCallback onToggleCompleted;
  final VoidCallback onToggleImportant;
  final Task task;

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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TaskPage(task.id),
              fullscreenDialog: true,
            ),
          );
        },
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
              ? style.bodyMedium?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.grey,
                  color: Colors.grey,
                )
              : style.bodyLarge,
        ),
        subtitle: (task.dateline != null ||
                task.reminder != null ||
                task.notes.isNotEmpty)
            ? _TaskDetails(
                dateline: task.dateline,
                reminder: task.reminder,
                notes: task.notes,
                isCompleted: isCompleted,
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
  });

  final DateTime? dateline;
  final DateTime? reminder;
  final String notes;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    if (dateline == null && reminder == null && notes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (dateline != null)
          Row(
            children: [
              Icon(
                IconsaxOutline.calendar_1,
                size: 12,
                color: isCompleted ? Colors.grey : Colors.white,
              ),
              const Gap(4.0),
              Text(
                DateFormat.yMMMMEEEEd().format(dateline!),
                style: isCompleted
                    ? style.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                        color: Colors.grey,
                      )
                    : style.bodySmall,
              ),
            ],
          ),
        if (reminder != null)
          Row(
            children: [
              Icon(
                IconsaxOutline.notification,
                size: 12,
                color: isCompleted ? Colors.grey : Colors.white,
              ),
              const Gap(4.0),
              Text(
                DateFormat.yMMMMEEEEd().format(reminder!),
                style: isCompleted
                    ? style.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                        color: Colors.grey,
                      )
                    : style.bodySmall,
              ),
            ],
          ),
        if (notes.isNotEmpty)
          Row(
            children: [
              Icon(
                IconsaxOutline.note_1,
                size: 12,
                color: isCompleted ? Colors.grey : Colors.white,
              ),
              const Gap(4.0),
              SizedBox(
                width: 200,
                child: Text(
                  notes,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isCompleted
                      ? style.bodySmall?.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                        )
                      : style.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
