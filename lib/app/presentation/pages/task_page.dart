import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class TaskPage extends ConsumerWidget {
  static String routePath = '/task/:id';

  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider).task;

    if (task == null) {
      return _EmptyTask();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.isCompleted != null
              ? S.of(context).home_completed
              : S.of(context).home_pending,
          style: TextStyle(
            color: task.isCompleted != null ? null : dueDateColor(task.dueDate),
          ),
        ),
        actions: [
          task.isCompleted != null
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: Icon(
                    dueDateIcon(task.dueDate),
                    color: dueDateColor(task.dueDate),
                  ),
                ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            _TextField(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 16),
                onTap: ref.read(taskProvider.notifier).onAddDueDate,
                leading: const Icon(HeroIcons.calendar),
                title: Text(
                  task.dueDate != null
                      ? DateFormat()
                          .add_yMMMMEEEEd()
                          .format(task.dueDate!)
                          .toString()
                      : S.of(context).button_add_due_date,
                ),
                trailing: Visibility(
                  visible: task.dueDate != null,
                  child: IconButton(
                    onPressed: ref.read(taskProvider.notifier).onRemoveDueDate,
                    icon: const Icon(BoxIcons.bx_x),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 16),
                onTap: ref.read(taskProvider.notifier).onAddReminder,
                leading: const Icon(HeroIcons.bell_alert),
                title: Text(
                  task.reminder != null
                      ? DateFormat().format(task.reminder!).toString()
                      : S.of(context).button_reminder,
                ),
                trailing: Visibility(
                  visible: task.reminder != null,
                  child: IconButton(
                    onPressed: ref.read(taskProvider.notifier).onRemoveReminder,
                    icon: const Icon(BoxIcons.bx_x),
                  ),
                ),
              ),
            ),
            CustomFilledButton(
              margin: const EdgeInsets.only(top: 16),
              onPressed: ref.read(taskProvider.notifier).onDelete,
              foregroundColor: Colors.red,
              backgroundColor: Colors.red.shade900.withOpacity(.1),
              icon: const Icon(HeroIcons.trash, size: 16),
              child: Text(S.of(context).button_delete_task),
            )
          ],
        ),
      ),
    );
  }
}

class _EmptyTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(HeroIcons.clipboard_document_check, size: 32),
            const SizedBox(height: defaultPadding),
            Text(S.of(context).task_empty_title, style: style.headlineSmall),
            const SizedBox(height: 8),
            Text(S.of(context).task_empty_subtitle, style: style.titleMedium),
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
    String? message = ref.read(taskProvider).task?.message;
    controller = TextEditingController(text: message ?? '');
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskProvider).task!;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
        filled: focusNode.hasFocus,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: IconButton(
            onPressed: ref.read(taskProvider.notifier).onToggleComplete,
            icon: task.isCompleted != null
                ? const Icon(BoxIcons.bx_check_circle)
                : const Icon(BoxIcons.bx_circle),
          ),
        ),
        hintText: S.of(context).home_button_add,
      ),
    );
  }
}
