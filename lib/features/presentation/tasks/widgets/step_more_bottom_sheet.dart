import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';

class StepMoreBottomSheet extends ConsumerWidget {
  const StepMoreBottomSheet({
    required this.stepId,
    required this.taskId,
    super.key,
  });

  final int stepId;
  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: StepMoreBottomSheet Implement build method.

    final notifier = ref.read(taskProvider(taskId).notifier);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                onTap: () {},
                leading: const Icon(IconsaxOutline.status_up),
                title: const Text('Convertir en una tarea'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  context.pop();
                  notifier.deleteStep(stepId);
                },
                leading: const Icon(IconsaxOutline.trash),
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                title: const Text('Eliminar paso'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
