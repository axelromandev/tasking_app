import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTaskDeleteDialog extends ConsumerWidget {
  const ListTaskDeleteDialog(this.listId);

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final list = ref.watch(listTasksProvider(listId)).list!;

    return AlertDialog(
      title: Text(
        S.dialogs.listTasksDelete.title,
        style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.dialogs.listTasksDelete.subtitle,
            style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          if (list.pendingTasksLength > 0)
            Container(
              margin: const EdgeInsets.only(top: defaultPadding),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                S.dialogs.listTasksDelete
                    .warning(pendingTasks: list.pendingTasksLength),
                style: style.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomFilledButton(
                height: 50,
                onPressed: () => Navigator.pop(context, false),
                backgroundColor: AppColors.card,
                foregroundColor: Colors.white,
                child: Text(S.common.buttons.cancel),
              ),
            ),
            const Gap(defaultPadding),
            Expanded(
              child: CustomFilledButton(
                height: 50,
                onPressed: () => Navigator.pop(context, true),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                child: (list.pendingTasksLength > 0)
                    ? const Text('Borrar Todo')
                    : const Text('Borrar'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
