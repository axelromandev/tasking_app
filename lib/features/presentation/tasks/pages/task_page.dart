import 'dart:io';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: implement TaskPage SLANG

    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final list = ref.watch(listTasksProvider(task.listId)).list!;

    final provider = ref.watch(taskProvider(task));
    final notifier = ref.read(taskProvider(task).notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          iconSize: 30.0,
          icon: const Icon(IconsaxOutline.arrow_left_2, size: 20),
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
            iconSize: 18,
            icon: const Icon(IconsaxOutline.trash),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: provider.title,
              style: style.titleLarge,
              autocorrect: false,
              maxLines: null,
              cursorColor: colorPrimary,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    //TODO: update task completedAt
                  },
                  color: Colors.white60,
                  icon: Icon(
                    task.completedAt != null
                        ? IconsaxOutline.record_circle
                        : IconsaxOutline.tick_circle,
                  ),
                ),
                hintText: S.pages.task.placeholderTitle,
                filled: false,
              ),
              onChanged: notifier.onTitleChanged,
            ),
            TextButton.icon(
              onPressed: () {
                //TODO: add more steps tasks
              },
              style: TextButton.styleFrom(
                foregroundColor: colorPrimary,
                overlayColor: Colors.transparent,
              ),
              icon: const Icon(IconsaxOutline.add),
              label: const Text('Agregar pasos'),
            ),
            if (provider.reminder != null)
              ListTile(
                onTap: () {
                  //TODO: update reminder
                },
                contentPadding: const EdgeInsets.only(left: defaultPadding),
                leading: Icon(
                  IconsaxOutline.notification,
                  color: colorPrimary,
                  size: 20,
                ),
                title: Text(
                  DateFormat.MMMEd().format(provider.reminder!),
                ),
                trailing: IconButton(
                  onPressed: () {
                    //TODO: remove reminder
                  },
                  icon: const Icon(IconsaxOutline.minus),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: TextButton.icon(
                  onPressed: () => notifier.onUpdateReminder(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white70,
                    overlayColor: Colors.transparent,
                  ),
                  icon: const Icon(IconsaxOutline.notification, size: 20),
                  label: const Text('Recordarme'),
                ),
              ),
            if (task.dateline != null)
              ListTile(
                onTap: () {
                  //TODO: update dateline
                },
                contentPadding: const EdgeInsets.only(left: defaultPadding),
                leading: Icon(
                  IconsaxOutline.calendar_2,
                  color: colorPrimary,
                  size: 20,
                ),
                title: Text(
                  DateFormat.MMMEd().format(provider.dateline!),
                ),
                trailing: IconButton(
                  onPressed: () {
                    //TODO: remove dateline
                  },
                  icon: const Icon(IconsaxOutline.minus),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: TextButton.icon(
                  onPressed: () {
                    //TODO: add dateline
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white70,
                    overlayColor: Colors.transparent,
                  ),
                  icon: const Icon(IconsaxOutline.calendar_2, size: 20),
                  label: const Text('Fecha límite'),
                ),
              ),
            const Gap(defaultPadding),
            const Divider(height: 0),
            TextFormField(
              initialValue: provider.notes,
              maxLines: 4,
              autocorrect: false,
              cursorColor: colorPrimary,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: S.pages.task.placeholderNote,
                filled: false,
              ),
              onChanged: notifier.onNoteChanged,
            ),
          ],
        ),
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
