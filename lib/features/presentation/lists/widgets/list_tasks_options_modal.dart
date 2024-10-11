import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTasksOptionsModal extends ConsumerWidget {
  const ListTasksOptionsModal(
    this.contextPage,
    this.listId, {
    super.key,
  });

  final BuildContext contextPage;
  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(listTasksProvider(listId));
    final notifier = ref.read(listTasksProvider(listId).notifier);

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
                S.modals.listTasksOptions.tasks.title,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onMarkIncompleteAllTasks();
              },
              enabled: provider.completed.isNotEmpty,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.record, size: 18),
              title: Text(
                S.modals.listTasksOptions.tasks.incompleteAllTasks,
              ),
              iconColor: colorPrimary,
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onMarkCompleteAllTasks();
              },
              enabled: provider.pending.isNotEmpty,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.tick_circle, size: 18),
              title: Text(S.modals.listTasksOptions.tasks.completeAllTasks),
              iconColor: colorPrimary,
            ),
            ListTile(
              onTap: () {
                context.pop();
                notifier.onDeleteCompletedAllTasks();
              },
              enabled: provider.completed.isNotEmpty,
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.minus_cirlce, size: 18),
              title: Text(
                S.modals.listTasksOptions.tasks.deleteAllCompletedTasks,
              ),
              iconColor: colorPrimary,
            ),
            const Divider(),
            ListTile(
              onTap: () async {
                context.pop();
                final result = await showDialog<bool?>(
                  context: context,
                  builder: (_) => ListTaskDeleteDialog(provider.list!.id),
                );
                if (result != null && result) {
                  notifier.onDelete(contextPage);
                }
              },
              shape: const RoundedRectangleBorder(),
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.trash, size: 18),
              title: Text(S.modals.listTasksOptions.list.delete),
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
