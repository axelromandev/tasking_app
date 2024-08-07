import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

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

    final provider = ref.watch(taskAddModalProvider(listId));
    final notifier = ref.read(taskAddModalProvider(listId).notifier);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: TextFormField(
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
            suffixIcon: (provider.name.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      notifier.onSubmit();
                      notifier.focusNode.requestFocus();
                    },
                    color: color,
                    icon: const Icon(BoxIcons.bx_send),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
