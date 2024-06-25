import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import '../dialogs/task_delete_dialog.dart';
import '../modals/reminder_options_modal.dart';
import '../providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(taskProvider(task));
    final notifier = ref.read(taskProvider(task).notifier);

    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(BoxIcons.bx_arrow_back),
          color: colorPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            iconSize: 20.0,
            color: colorPrimary,
            icon: const Icon(BoxIcons.bx_pin),
          ),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => const ReminderOptionsModal(),
            ),
            iconSize: 20.0,
            color: colorPrimary,
            icon: const Icon(BoxIcons.bx_bell),
          ),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (contextModel) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      // onTap: () => notifier.onDeleteTask().then((_) {
                      //   Navigator.pop(contextModel);
                      //   Navigator.pop(context);
                      // }),
                      onTap: () async {
                        Navigator.pop(contextModel);
                        await showDialog(
                          context: context,
                          builder: (_) => TaskDeleteDialog(),
                        );
                      },
                      shape: const RoundedRectangleBorder(),
                      iconColor: colorPrimary,
                      leading: const Icon(BoxIcons.bx_trash),
                      title: Text(S.buttons.delete),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: const RoundedRectangleBorder(),
                      iconColor: colorPrimary,
                      leading: const Icon(BoxIcons.bx_copy),
                      title: const Text('Make a copy'),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: const RoundedRectangleBorder(),
                      iconColor: colorPrimary,
                      leading: const Icon(BoxIcons.bx_archive),
                      title: const Text('Archive'),
                    ),
                  ],
                ),
              ),
            ),
            iconSize: 20.0,
            color: colorPrimary,
            icon: const Icon(BoxIcons.bx_dots_vertical_rounded),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: provider.message,
            style: style.titleLarge,
            autocorrect: false,
            maxLines: null,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: S.pages.task.placeholderTitle,
              filled: false,
            ),
            onChanged: notifier.onTitleChanged,
          ),
          TextFormField(
            initialValue: provider.note,
            maxLines: null,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: S.pages.task.placeholderNote,
              filled: false,
            ),
            onChanged: notifier.onNoteChanged,
          ),
          if (task.subtasks.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: provider.subtasks.length,
              itemBuilder: (context, index) {
                final subtask = provider.subtasks.toList()[index];
                return TextFormField(
                  initialValue: subtask.message,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  style: style.bodyLarge?.copyWith(
                    color: subtask.completed ? Colors.white60 : Colors.white,
                    decoration: subtask.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white60,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Subtask',
                    filled: false,
                    prefixIcon: IconButton(
                      onPressed: () =>
                          notifier.onSubtaskToggleCompleted(subtask),
                      iconSize: 20.0,
                      color: subtask.completed ? Colors.white60 : Colors.white,
                      icon: subtask.completed
                          ? const Icon(BoxIcons.bx_check_circle)
                          : const Icon(BoxIcons.bx_circle),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => notifier.onSubtaskDelete(subtask),
                      iconSize: 20.0,
                      color: subtask.completed ? Colors.white60 : Colors.white,
                      icon: const Icon(BoxIcons.bx_x),
                    ),
                  ),
                );
              },
            ),
          TextFormField(
            autocorrect: false,
            onFieldSubmitted: notifier.onSubtaskAdd,
            decoration: InputDecoration(
              hintText: 'Subtasks',
              filled: false,
              prefixIcon: IconButton(
                onPressed: () {},
                iconSize: 20.0,
                color: Colors.white70,
                icon: const Icon(BoxIcons.bx_circle),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              //TODO: Add date time edited
              'Edited 2:07 PM *',
              style: style.bodySmall?.copyWith(
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
