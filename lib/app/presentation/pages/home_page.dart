import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class HomePage extends StatelessWidget {
  static String routePath = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cardDarkColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: const Icon(BoxIcons.bxs_crown, color: Colors.yellow),
                ),
              ),
              const SizedBox(width: defaultPadding / 2),
              Text(S.of(context).app_name, style: style.headlineSmall),
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => context.push(SettingsPage.routePath),
              icon: const Icon(BoxIcons.bx_cog),
            ),
          ],
        ),
        body: _BuildTasks(),
        bottomNavigationBar: _ButtonAddTask(),
      ),
    );
  }
}

class _ButtonAddTask extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ButtonAddTask> createState() => _ButtonAddTaskState();
}

class _ButtonAddTaskState extends ConsumerState<_ButtonAddTask> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(controllerProvider);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: TextFormField(
          onChanged: (_) => setState(() {}),
          controller: controller,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            ref.read(homeProvider.notifier).onSubmit(value);
            setState(() {});
          },
          style: const TextStyle(fontSize: 16),
          maxLines: null,
          decoration: InputDecoration(
            prefixIcon: controller.text.isEmpty
                ? const Icon(HeroIcons.plus)
                : const Icon(BoxIcons.bx_circle),
            hintText: S.of(context).home_button_add,
          ),
        ),
      ),
    );
  }
}

class _BuildTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(homeProvider);

    final listCompleted =
        tasks.where((task) => task.isCompleted != null).toList();
    listCompleted.sort((a, b) => b.isCompleted!.compareTo(a.isCompleted!));

    final listPending =
        tasks.where((task) => task.isCompleted == null).toList();
    listPending.sort((a, b) => b.createAt!.compareTo(a.createAt!));

    final style = Theme.of(context).textTheme;

    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(HeroIcons.clipboard_document_check, size: 32),
            Text(S.of(context).home_empty_tasks, style: style.headlineSmall),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        ...listPending.map((task) => _BuildTask(task)).toList(),
        if (listCompleted.isNotEmpty)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (listPending.isNotEmpty)
                const SizedBox(height: defaultPadding * 2),
              Row(
                children: [
                  const Icon(
                    BoxIcons.bx_check_circle,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(S.of(context).home_completed,
                      style: style.titleMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      )),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ...listCompleted.map((task) => _BuildTask(task)).toList(),
      ],
    );
  }
}

class _BuildTask extends ConsumerWidget {
  final Task task;
  const _BuildTask(this.task);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardTask(
      onShowDetails: () => context.push(
        TaskPage.routePath.replaceAll(':id', '${task.id}'),
      ),
      onCheckTask: () => ref.read(homeProvider.notifier).onToggleCheck(task),
      task: task,
    );
  }
}
