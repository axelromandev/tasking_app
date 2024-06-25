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
  const ListTasksOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);
    final list = ref.watch(listTasksProvider);
    final notifier = ref.read(listTasksProvider.notifier);

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
              onTap: () {
                context.pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ListTasksUpdateModal(list!),
                );
              },
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: colorPrimary,
              leading: const Icon(BoxIcons.bx_pencil, size: 18),
              title: Text(S.modals.listTasksOptions.list.edit),
            ),
            ListTile(
              onTap: () {
                context.pop();
                showDialog(
                  context: context,
                  builder: (context) => _DeleteDialog(),
                );
              },
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: colorPrimary,
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
              enabled: list?.tasks.isNotEmpty ?? false,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: colorPrimary,
              leading: const Icon(BoxIcons.bx_circle, size: 18),
              title: Text(S.modals.listTasksOptions.tasks.incompleteAllTasks),
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onMarkCompleteAllTasks();
              },
              enabled: list?.tasks.isNotEmpty ?? false,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: colorPrimary,
              leading: const Icon(BoxIcons.bx_check_circle, size: 18),
              title: Text(S.modals.listTasksOptions.tasks.completeAllTasks),
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onDeleteCompletedAllTasks();
              },
              enabled: list?.tasks.isNotEmpty ?? false,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              iconColor: colorPrimary,
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
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text(S.buttons.cancel),
        ),
        FilledButton(
          onPressed: () {
            context.pop();
            ref.read(listTasksProvider.notifier).onDelete();
          },
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
