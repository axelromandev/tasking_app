import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../providers/task_add_modal_provider.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final provider = ref.watch(taskAddModalProvider);
    final notifier = ref.read(taskAddModalProvider.notifier);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    onChanged: notifier.onNameChanged,
                    controller: notifier.controller,
                    // focusNode: notifier.focusNode,
                    textInputAction: TextInputAction.done,
                    // onFieldSubmitted: (_) => notifier.onSubmit(context),
                    style: const TextStyle(fontSize: 16),
                    maxLines: null,
                    autocorrect: false,
                    cursorColor: colors.primary,
                    decoration: const InputDecoration(
                      hintText: 'new task',
                    ),
                  ),
                ),
                const Gap(defaultPadding),
                Container(
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: provider.name.isNotEmpty
                        ? notifier.onSubmit
                        : notifier.onMicrophone,
                    visualDensity: VisualDensity.comfortable,
                    color: Colors.black,
                    icon: provider.name.isNotEmpty
                        ? const Icon(BoxIcons.bx_plus)
                        : const Icon(BoxIcons.bx_microphone),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
