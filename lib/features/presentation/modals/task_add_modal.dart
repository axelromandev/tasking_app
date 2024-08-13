import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../i18n/generated/translations.g.dart';
import '../providers/list_tasks_provider.dart';
import '../providers/task_add_modal_provider.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal(this.listId, {super.key});

  final int listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listTasksProvider(listId));
    final color = Color(list.color!);

    ref.watch(taskAddModalProvider(listId).notifier);
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
              cursorColor: color,
              onFieldSubmitted: (value) {
                notifier.onSubmit();
                notifier.focusNode.requestFocus();
              },
              decoration: InputDecoration(
                filled: false,
                hintText: S.common.modals.taskAdd.placeholder,
                prefixIcon: Icon(
                  BoxIcons.bx_circle,
                  color: color,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {}, //TODO: task add my day
                  icon: const Icon(BoxIcons.bx_sun),
                ),
                IconButton(
                  onPressed: () {}, //TODO: add reminder
                  icon: const Icon(BoxIcons.bx_bell),
                ),
                IconButton(
                  onPressed: () {}, //TODO: add calendar due
                  icon: const Icon(BoxIcons.bx_calendar),
                ),
                IconButton(
                  onPressed: () {}, //TODO: add note
                  icon: const Icon(BoxIcons.bx_note),
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
