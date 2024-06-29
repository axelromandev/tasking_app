import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';
import '../providers/list_tasks_provider.dart';
import 'list_tasks_update_modal.dart';

class ListTasksOptionsModal extends ConsumerWidget {
  const ListTasksOptionsModal(this.contextPage, this.listId, {super.key});

  final BuildContext contextPage;
  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listTasksProvider(listId));
    final notifier = ref.read(listTasksProvider(listId).notifier);

    final color = Color(list.color ?? 0xFF000000);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                S.modals.listTasksOptions.list.title,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              onTap: () async {
                context.pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ListTasksUpdateModal(list),
                );
              },
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: color,
              leading: const Icon(BoxIcons.bx_pencil, size: 18),
              title: Text(S.modals.listTasksOptions.list.edit),
            ),
            ListTile(
              onTap: () async {
                context.pop();
                final result = await showDialog<bool?>(
                  context: context,
                  builder: (_) => _DeleteDialog(),
                );
                if (result != null && result) {
                  notifier.onDelete(contextPage);
                }
              },
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: color,
              leading: const Icon(BoxIcons.bx_trash, size: 18),
              title: Text(S.modals.listTasksOptions.list.delete),
            ),
            const Gap(defaultPadding),
            Container(
              margin: const EdgeInsets.only(left: defaultPadding),
              child: Text(
                S.modals.listTasksOptions.tasks.title,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onMarkIncompleteAllTasks();
              },
              enabled: list.tasks.isNotEmpty,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: color,
              leading: const Icon(BoxIcons.bx_circle, size: 18),
              title: Text(S.modals.listTasksOptions.tasks.incompleteAllTasks),
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onMarkCompleteAllTasks();
              },
              enabled: list.tasks.isNotEmpty,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: color,
              leading: const Icon(BoxIcons.bx_check_circle, size: 18),
              title: Text(S.modals.listTasksOptions.tasks.completeAllTasks),
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onDeleteCompletedAllTasks();
              },
              enabled: list.tasks.isNotEmpty,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: color,
              leading: const Icon(BoxIcons.bx_x_circle, size: 18),
              title:
                  Text(S.modals.listTasksOptions.tasks.deleteAllCompletedTasks),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(S.dialogs.listTasksDelete.title, style: style.titleLarge),
      content: Text(
        S.dialogs.listTasksDelete.subtitle,
        style: style.bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text(S.buttons.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: Text(S.buttons.delete),
        ),
      ],
    );
  }
}
