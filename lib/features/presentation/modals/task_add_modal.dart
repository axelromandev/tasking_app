import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';
import '../providers/task_add_modal_provider.dart';
import 'reminder_options_modal.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);
    // final provider = ref.watch(taskAddModalProvider);
    final notifier = ref.read(taskAddModalProvider.notifier);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: TextFormField(
          autofocus: true,
          maxLines: null,
          onChanged: notifier.onNameChanged,
          controller: notifier.controller,
          focusNode: notifier.focusNode,
          textInputAction: TextInputAction.done,
          style: const TextStyle(fontSize: 16),
          cursorColor: colorPrimary,
          onFieldSubmitted: (value) {
            notifier.onSubmit();
            notifier.focusNode.requestFocus();
          },
          decoration: InputDecoration(
            filled: false,
            hintText: S.modals.taskAdd.placeholder,
            suffixIcon: IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => const ReminderOptionsModal(),
              ),
              iconSize: 20.0,
              color: colorPrimary,
              icon: const Icon(BoxIcons.bx_bell),
            ),
          ),
        ),
      ),
    );
  }
}
