import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../providers/providers.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final task = ref.watch(taskProvider).task;

    if (task == null) return const CircularProgressIndicator();

    final notifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.isCompleted != null
              ? S.of(context).home_completed
              : S.of(context).home_pending,
          style: TextStyle(
            color: task.isCompleted != null ? colors.primary : null,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            _TextField(),
            const Gap(defaultPadding / 2),
            ListTile(
              onTap: notifier.onAddDueDate,
              iconColor: task.dueDate != null ? colors.primary : null,
              contentPadding: const EdgeInsets.only(left: defaultPadding),
              leading: const Icon(BoxIcons.bx_calendar),
              title: Text(notifier.formatDate()),
              trailing: Visibility(
                visible: task.dueDate != null,
                child: IconButton(
                  onPressed: ref.read(taskProvider.notifier).onRemoveDueDate,
                  icon: const Icon(BoxIcons.bx_x),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                //TODO: Add reminder functionality
              },
              contentPadding: const EdgeInsets.only(left: defaultPadding),
              leading: const Icon(BoxIcons.bx_bell),
              title: const Text('Remind me'),
            ),
            const Gap(defaultPadding / 2),
            ListTile(
              onTap: ref.read(taskProvider.notifier).onDelete,
              iconColor: Colors.red,
              textColor: Colors.red,
              leading: const Icon(BoxIcons.bx_trash),
              title: Text(S.of(context).button_delete_task),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends ConsumerStatefulWidget {
  @override
  ConsumerState<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends ConsumerState<_TextField> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    String? message = ref.read(taskProvider).task!.message;
    controller = TextEditingController(text: message);
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final task = ref.watch(taskProvider).task!;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        if (value.toLowerCase() == task.message.toLowerCase()) {
          focusNode.unfocus();
          return;
        }
        if (value.isEmpty) {
          controller.text = task.message;
          focusNode.unfocus();
          return;
        }
        ref.read(taskProvider.notifier).onChangeMessage(value);
      },
      style: const TextStyle(fontSize: 16),
      maxLines: null,
      cursorColor: isDarkMode ? Colors.white : Colors.black,
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(
            color: colors.primary.withOpacity(.6),
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: IconButton(
            onPressed: ref.read(taskProvider.notifier).onToggleComplete,
            icon: Icon(
              task.isCompleted != null
                  ? BoxIcons.bx_check_circle
                  : BoxIcons.bx_circle,
              color: colors.primary,
            ),
          ),
        ),
        hintText: S.of(context).home_button_add,
      ),
    );
  }
}
