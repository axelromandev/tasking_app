import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/const/constants.dart';
import 'package:tasking/core/core.dart';

import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../providers/task_provider.dart';

class TaskModal extends ConsumerWidget {
  const TaskModal(this.task, {super.key});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(taskProvider(task));

    return LayoutBuilder(builder: (context, _) {
      return AnimatedPadding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, minHeight: 150),
          child: _BuilderModal(provider.task),
        ),
      );
    });
  }
}

class _BuilderModal extends ConsumerWidget {
  const _BuilderModal(this.task);
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final notifier = ref.read(taskProvider(task).notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: defaultPadding),
            title: Text(
              task.isCompleted != null
                  ? S.of(context).home_completed
                  : S.of(context).home_pending,
              style: TextStyle(
                color: task.isCompleted != null ? colors.primary : null,
              ),
            ),
            trailing: TextButton(
              onPressed: () => notifier.onDelete(context),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(S.of(context).button_delete_task),
            ),
          ),
          const Gap(4),
          TextFormField(
            maxLines: null,
            initialValue: task.message,
            onChanged: notifier.onChangeMessage,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: colors.primary.withOpacity(.6),
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: IconButton(
                  onPressed: notifier.onToggleComplete,
                  icon: Icon(
                    task.isCompleted != null
                        ? BoxIcons.bx_check_circle
                        : BoxIcons.bx_circle,
                    color: colors.primary,
                  ),
                ),
              ),
              hintText: S.of(context).home_button_add,
            ),
          ),
          const Gap(defaultPadding / 2),
          Row(
            children: [
              TextButton.icon(
                onPressed: task.dueDate?.date != null
                    ? () => notifier.onEditDueDate(context)
                    : () => notifier.onAddDueDate(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: Icon(
                  task.dueDate?.date != null
                      ? task.dueDate!.isReminder
                          ? BoxIcons.bx_bell
                          : BoxIcons.bx_calendar
                      : BoxIcons.bx_plus,
                  size: 18,
                  color: colors.primary,
                ),
                label: task.dueDate?.date != null
                    ? Text(
                        formatDate(
                          task.dueDate!.date!,
                          task.dueDate!.isReminder,
                        ),
                        style: style.bodyMedium)
                    : Text(S.of(context).button_due_date),
              ),
              if (task.dueDate?.date != null)
                GestureDetector(
                  onTap: notifier.onRemoveDueDate,
                  child: Icon(BoxIcons.bx_x, color: colors.primary),
                ),
            ],
          ),
          const Gap(defaultPadding * 2),
        ],
      ),
    );
  }
}
