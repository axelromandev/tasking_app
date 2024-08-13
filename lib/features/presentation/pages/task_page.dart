import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../i18n/generated/translations.g.dart';
import '../../app.dart';
import '../dialogs/task_delete_dialog.dart';
import '../providers/list_tasks_provider.dart';
import '../providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final list = ref.watch(listTasksProvider(task.listId));
    final color = Color(list.color!);

    final provider = ref.watch(taskProvider(task));
    final notifier = ref.read(taskProvider(task).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(BoxIcons.bx_arrow_back),
          color: color,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(list.title, style: style.bodyLarge),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool?>(
                context: context,
                builder: (_) => TaskDeleteDialog(),
              );
              if (result != null && result) {
                await notifier.onDeleteTask();
                Navigator.pop(context);
              }
            },
            iconSize: 20.0,
            color: color,
            icon: const Icon(BoxIcons.bx_trash),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: provider.title,
            style: style.titleLarge,
            autocorrect: false,
            maxLines: null,
            cursorColor: color,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                color: Colors.white60,
                icon: const Icon(BoxIcons.bx_circle),
              ),
              hintText: S.pages.task.placeholderTitle,
              filled: false,
            ),
            onChanged: notifier.onTitleChanged,
          ),
          TextButton.icon(
            onPressed: () {}, //TODO: add more steps tasks
            style: TextButton.styleFrom(foregroundColor: color),
            icon: const Icon(BoxIcons.bx_plus),
            label: const Text('Add a step'),
          ),
          if (task.reminder != null)
            ListTile(
              contentPadding: const EdgeInsets.only(left: defaultPadding),
              leading: Icon(BoxIcons.bx_bell, color: color, size: 20),
              title: Text(HumanFormat.datetime(task.reminder)),
              trailing: IconButton(
                onPressed: () {}, //TODO: remove reminder
                color: Colors.white54,
                icon: const Icon(BoxIcons.bx_x),
              ),
            )
          else
            TextButton.icon(
              onPressed: () => notifier.onUpdateReminder(context),
              style: TextButton.styleFrom(foregroundColor: color),
              icon: const Icon(BoxIcons.bx_bell, size: 20),
              label: const Text('Remind me'),
            ),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: color),
            icon: const Icon(BoxIcons.bx_calendar, size: 20),
            label: const Text('Add due date'),
          ),
          TextFormField(
            initialValue: provider.note,
            maxLines: null,
            autocorrect: false,
            cursorColor: color,
            decoration: InputDecoration(
              hintText: S.pages.task.placeholderNote,
              filled: false,
            ),
            onChanged: notifier.onNoteChanged,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.pages.task.edited(time: HumanFormat.time(task.updatedAt)),
              style: style.bodySmall?.copyWith(color: Colors.white60),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
