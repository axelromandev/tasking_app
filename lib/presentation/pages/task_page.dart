import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/domain/domain.dart';
import 'package:tasking/presentation/providers/providers.dart';
import 'package:tasking/presentation/shared/shared.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final list = ref.watch(listTasksProvider(task.listId));

    final provider = ref.watch(taskProvider(task));
    final notifier = ref.read(taskProvider(task).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          iconSize: 30.0,
          icon: const Icon(BoxIcons.bx_x),
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
            color: list.color,
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
            cursorColor: list.color,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                color: Colors.white60,
                icon: Icon(
                  task.completed
                      ? BoxIcons.bxs_check_circle
                      : BoxIcons.bx_circle,
                ),
              ),
              hintText: S.pages.task.placeholderTitle,
              filled: false,
            ),
            onChanged: notifier.onTitleChanged,
          ),
          TextButton.icon(
            onPressed: () {}, //TODO: add more steps tasks
            style: TextButton.styleFrom(
              foregroundColor: list.color,
              overlayColor: Colors.transparent,
            ),
            icon: const Icon(BoxIcons.bx_plus),
            label: const Text('Add a step'),
          ),
          if (task.reminder != null)
            ListTile(
              contentPadding: const EdgeInsets.only(left: defaultPadding),
              leading: Icon(BoxIcons.bx_bell, color: list.color, size: 20),
              title: Text(HumanFormat.datetime(task.reminder)),
              trailing: IconButton(
                onPressed: notifier.onRemoveReminder,
                color: Colors.white54,
                icon: const Icon(BoxIcons.bx_x),
              ),
            )
          else
            TextButton.icon(
              onPressed: () => notifier.onUpdateReminder(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white70,
                overlayColor: Colors.transparent,
              ),
              icon: const Icon(BoxIcons.bx_bell, size: 20),
              label: const Text('Remind me'),
            ),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white70,
              overlayColor: Colors.transparent,
            ),
            icon: const Icon(BoxIcons.bx_calendar, size: 20),
            label: const Text('Add due date'),
          ),
          const Gap(defaultPadding),
          const Divider(height: 0),
          TextFormField(
            initialValue: provider.note,
            maxLines: null,
            autocorrect: false,
            cursorColor: list.color,
            textInputAction: TextInputAction.done,
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
