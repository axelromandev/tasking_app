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
    final provider = ref.watch(listTasksProvider(listId));
    final notifier = ref.read(listTasksProvider(listId).notifier);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: defaultPadding,
          horizontal: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!provider.list!.isDefault)
                    ListTile(
                      onTap: () {
                        context.pop();
                        Navigator.of(contextPage).push(
                          MaterialPageRoute(
                            builder: (_) => ListTasksUpdatePage(provider.list!),
                          ),
                        );
                      },
                      leading: const Icon(IconsaxOutline.edit),
                      title: Text(
                        S.modals.listTasksOptions.list.edit,
                      ),
                    ),
                  ListTile(
                    onTap: () {
                      // TODO: Implement sorting tasks modal
                    },
                    leading: const Icon(IconsaxOutline.sort),
                    title: const Text('Ordenar por'), // SLANG: Sort by, button
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      context.pop();
                      notifier.onMarkCompleteAllTasks();
                    },
                    enabled: provider.pending.isNotEmpty,
                    leading: const Icon(IconsaxOutline.tick_circle),
                    title:
                        Text(S.modals.listTasksOptions.tasks.completeAllTasks),
                  ),
                  ListTile(
                    onTap: () {
                      context.pop();
                      notifier.onMarkIncompleteAllTasks();
                    },
                    enabled: provider.completed.isNotEmpty,
                    leading: const Icon(IconsaxOutline.record),
                    title: Text(
                      S.modals.listTasksOptions.tasks.incompleteAllTasks,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      context.pop();
                      notifier.onDeleteCompletedAllTasks();
                    },
                    enabled: provider.completed.isNotEmpty,
                    leading: const Icon(IconsaxOutline.minus_cirlce),
                    title: Text(
                      S.modals.listTasksOptions.tasks.deleteAllCompletedTasks,
                    ),
                  ),
                ],
              ),
            ),
            if (!provider.list!.isDefault)
              Card(
                child: ListTile(
                  onTap: () async {
                    context.pop();
                    final result = await showDialog<bool?>(
                      context: context,
                      builder: (_) => ListTaskDeleteDialog(provider.list!.id),
                    );
                    if (result != null && result) {
                      notifier.onDelete();
                    }
                  },
                  leading: const Icon(IconsaxOutline.trash),
                  title: Text(S.modals.listTasksOptions.list.delete),
                  iconColor: Colors.redAccent,
                  textColor: Colors.redAccent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
