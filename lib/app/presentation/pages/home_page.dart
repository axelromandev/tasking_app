import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../presentation.dart';

class HomePage extends StatelessWidget {
  static String routePath = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: SvgPicture.asset('assets/svg/logo_icon.svg', height: 24),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(S.of(context).home_title,
                        style: style.headlineLarge?.copyWith(
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _BuildTasks(),
            ],
          ),
        ),
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
            ref.read(taskProvider.notifier).onSubmit(value);
            setState(() {});
          },
          style: const TextStyle(color: Colors.white, fontSize: 16),
          maxLines: null,
          decoration: InputDecoration(
            prefixIcon: controller.text.isEmpty
                ? const Icon(HeroIcons.plus, color: Colors.white)
                : const Icon(BoxIcons.bx_circle, color: Colors.white),
            hintText: S.of(context).home_button_add,
            hintStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _BuildTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    final style = Theme.of(context).textTheme;

    if (tasks.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(HeroIcons.clipboard_document_check,
                  size: 32, color: Colors.white),
              Text(S.of(context).home_empty_tasks,
                  style: style.headlineSmall?.copyWith(
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          ...tasks
              .where((task) => !task.isCompleted)
              .map((task) => CardTask(
                    onTap: () =>
                        ref.read(taskProvider.notifier).onToggleCheck(task),
                    task: task,
                  ))
              .toList(),
          const SizedBox(height: defaultPadding),
          Text(S.of(context).home_completed,
              style: style.headlineSmall?.copyWith(
                fontWeight: FontWeight.w300,
                color: Colors.white,
              )),
          const SizedBox(height: 8),
          ...tasks
              .where((task) => task.isCompleted)
              .map((task) => CardTask(
                    onTap: () =>
                        ref.read(taskProvider.notifier).onToggleCheck(task),
                    task: task,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
