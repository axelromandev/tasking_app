import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskMoreBottomSheet extends ConsumerWidget {
  const TaskMoreBottomSheet({
    super.key,
    required this.taskId,
    required this.pageContext,
  });

  final int taskId;
  final BuildContext pageContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskProvider(taskId).notifier);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  context.pop();
                  notifier.onDeleteTask(pageContext);
                },
                leading: const Icon(IconsaxOutline.trash),
                title: Text(S.features.tasks.moreOptions.delete),
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
