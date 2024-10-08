import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal(this.listId, {super.key});

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final list = ref.watch(listTasksProvider(listId));

    final provider = ref.watch(taskAddModalProvider(listId));
    final notifier = ref.read(taskAddModalProvider(listId).notifier);

    return SingleChildScrollView(
      child: Container(
        color: AppColors.background,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              maxLines: null,
              autocorrect: false,
              onChanged: notifier.onNameChanged,
              controller: notifier.controller,
              focusNode: notifier.focusNode,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontSize: 16),
              // cursorColor: list.color,
              onFieldSubmitted: (value) {
                notifier.onSubmit();
                notifier.focusNode.requestFocus();
              },
              decoration: InputDecoration(
                filled: false,
                hintText: S.modals.taskAdd.placeholder,
                prefixIcon: const Icon(
                  IconsaxOutline.record,
                  color: Colors.white54,
                ),
              ),
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () => notifier.onDatelineChanged(context),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    overlayColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(IconsaxOutline.calendar_1, size: 20),
                  label: const Text('Set dateline'),
                ),
                TextButton.icon(
                  onPressed: () {}, //TODO: add reminder
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    overlayColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(IconsaxOutline.notification, size: 20),
                  label: const Text('Remind me'),
                ),
                TextButton.icon(
                  onPressed: () => notifier.onNotesChanged(context),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    overlayColor: Colors.transparent,
                    foregroundColor: (provider.notes.isNotEmpty)
                        ? Colors.amber
                        : Colors.white,
                  ),
                  icon: const Icon(IconsaxOutline.note, size: 20),
                  label: const Text('Notes'),
                ),
              ],
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
