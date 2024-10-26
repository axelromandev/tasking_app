import 'dart:io';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage(this.taskId, {super.key});

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //SLANG: translation labels

    final style = Theme.of(context).textTheme;

    final provider = ref.watch(taskProvider(taskId));

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final list = ref.watch(listTasksProvider(provider.listId)).list!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconsaxOutline.arrow_left_2),
        ),
        title: Text(list.title, style: style.bodyLarge),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => TaskMoreBottomSheet(
                taskId: taskId,
                pageContext: context,
              ),
            ),
            iconSize: 18,
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleInputField(taskId),
            _AddStepsTask(taskId),
            _AddDateline(taskId),
            _AddReminder(taskId),
            _Notes(taskId),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.pages.task.edited(time: HumanFormat.time(provider.updatedAt)),
              style: style.bodySmall?.copyWith(color: Colors.white60),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}

class _Notes extends ConsumerWidget {
  const _Notes(this.taskId);

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(taskProvider(taskId));
    final notifier = ref.read(taskProvider(taskId).notifier);

    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 12,
              right: 8,
            ),
            child: Icon(
              IconsaxOutline.note,
              color: provider.notes.isEmpty ? Colors.white70 : Colors.white,
            ),
          ),
          Flexible(
            child: TextFormField(
              initialValue: provider.notes,
              autocorrect: false,
              maxLines: null,
              cursorColor: colorPrimary,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                filled: false,
                hintText: S.pages.task.placeholderNote,
                hintStyle: style.bodyLarge?.copyWith(color: Colors.white70),
              ),
              onChanged: notifier.onNoteChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddReminder extends ConsumerWidget {
  const _AddReminder(this.taskId);

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(taskProvider(taskId));

    final bool hasReminder = provider.reminder != null;

    return Row(
      children: [
        Flexible(
          child: ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(),
            iconColor: hasReminder ? Colors.white : Colors.white70,
            textColor: hasReminder ? Colors.white : Colors.white70,
            leading: const Icon(IconsaxOutline.notification),
            title: const Text('Recordarme'),
          ),
        ),
        if (provider.reminder != null)
          IconButton(
            onPressed: () {},
            iconSize: 20,
            icon: const Icon(Icons.close),
          ),
      ],
    );
  }
}

class _AddDateline extends ConsumerWidget {
  const _AddDateline(this.taskId);

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(taskProvider(taskId));

    final bool hasDateline = provider.dateline != null;

    return Row(
      children: [
        Flexible(
          child: ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(),
            iconColor: hasDateline ? Colors.white : Colors.white70,
            textColor: hasDateline ? Colors.white : Colors.white70,
            leading: const Icon(IconsaxOutline.calendar_2),
            title: const Text('Fecha límite'),
          ),
        ),
        if (provider.reminder != null)
          IconButton(
            onPressed: () {},
            iconSize: 20,
            icon: const Icon(Icons.close),
          ),
      ],
    );
  }
}

class _AddStepsTask extends ConsumerWidget {
  const _AddStepsTask(this.taskId);

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return ListTile(
      onTap: () {},
      shape: const RoundedRectangleBorder(),
      iconColor: colorPrimary,
      textColor: colorPrimary,
      leading: const Icon(IconsaxOutline.add),
      title: const Text('Agregar pasos'),
    );
  }
}

class _TitleInputField extends ConsumerWidget {
  const _TitleInputField(this.taskId);

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(taskProvider(taskId));
    final notifier = ref.read(taskProvider(taskId).notifier);

    final bool isCompleted = provider.completedAt != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: notifier.onToggleCompleted,
            color: isCompleted ? Colors.white60 : Colors.white,
            icon: Icon(
              isCompleted ? IconsaxOutline.tick_circle : IconsaxOutline.record,
            ),
          ),
          const Gap(8),
          Flexible(
            child: TextFormField(
              initialValue: provider.title,
              style: style.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: isCompleted ? Colors.grey : Colors.white,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: isCompleted ? Colors.grey : Colors.white,
              ),
              autocorrect: false,
              maxLines: null,
              cursorColor: colorPrimary,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: false,
                contentPadding: EdgeInsets.zero,
                hintText: S.pages.task.placeholderTitle,
              ),
              onChanged: notifier.onTitleChanged,
            ),
          ),
        ],
      ),
    );
  }
}
