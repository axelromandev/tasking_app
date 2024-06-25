import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';
import '../providers/task_add_modal_provider.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);
    final provider = ref.watch(taskAddModalProvider);
    final notifier = ref.read(taskAddModalProvider.notifier);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: TextFormField(
          autofocus: true,
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
            suffixIcon: (provider.name.isNotEmpty)
                ? GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      notifier.onSubmit();
                    },
                    child: Icon(BoxIcons.bx_plus, color: colorPrimary),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
