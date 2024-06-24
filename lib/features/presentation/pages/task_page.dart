import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';
import '../../domain/domain.dart';
import '../providers/list_tasks_provider.dart';
import '../providers/show_list_tasks_provider.dart';
import '../providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final listTasks = ref.watch(listTasksProvider);
    final provider = ref.watch(taskProvider(task));
    final notifier = ref.read(taskProvider(task).notifier);

    final listTaskColor =
        (listTasks?.color != null) ? Color(listTasks!.color!) : colorPrimary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(BoxIcons.bx_x),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => _ChangeListTasks(
              onListTasksChanged: (value) {
                //TODO: Change list tasks selected
                notifier.onListTasksChanged(value);
                Navigator.pop(context);
              },
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            visualDensity: VisualDensity.compact,
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorIndicator(
                width: 10,
                height: 10,
                borderRadius: 30,
                color: listTaskColor,
              ),
              const Gap(8.0),
              Text('${listTasks?.name}'),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          const Gap(defaultPadding),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () => notifier.onDeleteTask(context).then((_) {
                          Navigator.pop(context);
                        }),
                        iconColor: Colors.redAccent,
                        leading: const Icon(BoxIcons.bx_trash, size: 20),
                        title: Text(S.buttons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            icon: const Icon(BoxIcons.bx_dots_vertical_rounded, size: 20),
          ),
        ],
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: provider.message,
              style: style.titleLarge,
              maxLines: null,
              decoration: InputDecoration(
                hintText: S.pages.task.placeholderTask,
                filled: false,
              ),
              onChanged: notifier.onMessageChanged,
            ),
          ),
          const Divider(height: 0),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: notifier.noteController,
              decoration: InputDecoration(
                hintText: S.pages.task.placeholderNote,
                filled: false,
                prefixIcon: Icon(
                  BoxIcons.bx_note,
                  size: 20,
                  color: (provider.note?.isEmpty ?? true)
                      ? Colors.white
                      : listTaskColor,
                ),
                suffixIcon: (provider.note?.isNotEmpty ?? false)
                    ? IconButton(
                        onPressed: notifier.onNoteDeleted,
                        color: Colors.grey,
                        icon: const Icon(BoxIcons.bx_x, size: 20),
                      )
                    : null,
              ),
              onChanged: notifier.onNoteChanged,
            ),
          ),
          const Divider(height: 0),
          if (provider.subtasks.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: provider.subtasks.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (_, index) {
                final subtask = provider.subtasks.toList()[index];
                return TextFormField(
                  initialValue: subtask.message,
                  textInputAction: TextInputAction.done,
                  style: style.bodyLarge?.copyWith(
                    color: subtask.completed ? Colors.white60 : Colors.white,
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    hintText: S.pages.task.placeholderSubtask,
                    prefixIcon: IconButton(
                      onPressed: () =>
                          notifier.onSubtaskToggleCompleted(subtask),
                      iconSize: 20,
                      color: subtask.completed ? Colors.white60 : Colors.white,
                      icon: subtask.completed
                          ? const Icon(BoxIcons.bx_check_circle)
                          : const Icon(BoxIcons.bx_circle),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => notifier.onSubtaskDelete(subtask),
                      icon: const Icon(BoxIcons.bx_x),
                      iconSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          if (provider.subtasks.isNotEmpty) const Divider(height: 0),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: notifier.subtaskAddController,
              onFieldSubmitted: notifier.onSubtaskAdd,
              decoration: InputDecoration(
                hintText: S.pages.task.placeholderSubtaskAdd,
                filled: false,
                prefixIcon:
                    const Icon(BoxIcons.bx_plus, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangeListTasks extends ConsumerWidget {
  const _ChangeListTasks({this.onListTasksChanged});

  final void Function(int listTasksId)? onListTasksChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allListTasks = ref.watch(showListTasksProvider);
    final selectId = ref.watch(listTasksProvider)!.id;

    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const Gap(8.0),
        itemCount: allListTasks.length,
        itemBuilder: (_, index) {
          final listTasks = allListTasks[index];
          return ListTile(
            onTap: () {
              onListTasksChanged?.call(listTasks.id);
              Navigator.pop(context);
            },
            tileColor: listTasks.id == selectId
                ? MyColors.cardDark
                : Colors.transparent,
            leading: ColorIndicator(
              width: 12,
              height: 12,
              borderRadius: 30,
              color: Color(listTasks.color!),
            ),
            title: Text(listTasks.name),
          );
        },
      ),
    );
  }
}
