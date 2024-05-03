import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../providers/add_task_provider.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(addTaskProvider);

    final notifier = ref.read(addTaskProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            autofocus: true,
            onChanged: notifier.onNameChanged,
            controller: notifier.controller,
            focusNode: notifier.focusNode,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => notifier.onSubmit(context),
            style: const TextStyle(fontSize: 16),
            maxLines: null,
            autocorrect: false,
            cursorColor: colors.primary,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: colors.primary.withOpacity(.6),
                ),
              ),
              hintText: S.of(context).home_button_add,
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: provider.dueDate != null
                    ? () => notifier.onEditDueDate(context)
                    : () => notifier.onAddDueDate(context),
                style: TextButton.styleFrom(
                  foregroundColor: provider.dueDate != null
                      ? colors.primary
                      : Colors.white70,
                ),
                child: Row(
                  children: [
                    const Icon(BoxIcons.bx_calendar, size: 16.0),
                    const SizedBox(width: 8.0),
                    provider.dueDate != null
                        ? Row(
                            children: [
                              Text(
                                DateFormat('E, d MMM y')
                                    .format(provider.dueDate!),
                                style: style.bodyMedium,
                              ),
                              if (provider.isReminder) ...[
                                const Gap(defaultPadding / 2),
                                Icon(BoxIcons.bx_bell,
                                    size: 14, color: colors.primary),
                                Text(
                                  ' ${DateFormat('jm').format(provider.dueDate!)}',
                                  style: style.bodyMedium,
                                ),
                              ],
                            ],
                          )
                        : Text(S.of(context).button_add_due_date),
                  ],
                ),
              ),
              if (provider.dueDate != null)
                GestureDetector(
                  onTap: notifier.onRemoveDueDate,
                  child: Icon(BoxIcons.bx_x, color: colors.primary),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
