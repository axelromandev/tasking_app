import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';

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
    // TODO: TaskOptionsModal Implement onTa

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
                title: const Text('Eliminar tarea'),
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
