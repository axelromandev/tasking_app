import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../domain/domain.dart';
import '../providers/list_tasks_provider.dart';
import '../providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final listTasks = ref.watch(listTasksProvider);
    final provider = ref.watch(taskProvider(task));

    final listTaskColor =
        (listTasks?.color != null) ? Color(listTasks!.color!) : colors.primary;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ColorIndicator(
              width: 15,
              height: 15,
              borderRadius: 30,
              color: listTaskColor,
            ),
            TextButton(
              onPressed: () {
                // TODO: change task list
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                visualDensity: VisualDensity.compact,
                foregroundColor: Colors.white,
              ),
              child: Row(
                children: [
                  Text(listTasks?.name ?? 'List'),
                  const Gap(8.0),
                  const Icon(BoxIcons.bx_chevron_down, size: 20),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(BoxIcons.bxs_trash, size: 16),
          ),
        ],
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          TextFormField(
            initialValue: provider.message,
            style: style.titleLarge,
            maxLines: null,
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Task name',
            ),
          ),
          const Gap(8.0),
          if (provider.note?.isEmpty ?? false)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Icon(BoxIcons.bx_note, size: 20, color: listTaskColor),
                  const Gap(defaultPadding),
                  Expanded(
                    child: TextFormField(
                      initialValue: provider.note,
                      maxLines: null,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        filled: false,
                        hintText: 'Add note',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(BoxIcons.bx_x, size: 20),
                  ),
                ],
              ),
            ),
          if (provider.reminder != null)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(BoxIcons.bx_calendar, size: 20),
                    const Gap(defaultPadding * 2),
                    Text(
                      provider.reminder.toString(),
                      style: style.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, bottom: 8.0, top: 8.0),
                          child: Text(
                            'Select item you want to add',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.white70),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(BoxIcons.bx_note, size: 20),
                          title: const Text('Note'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(BoxIcons.bx_list_ul, size: 20),
                          title: const Text('Subtask'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(BoxIcons.bx_plus_circle, size: 20),
                  const Gap(defaultPadding * 2),
                  Text('Add items', style: style.bodyLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
