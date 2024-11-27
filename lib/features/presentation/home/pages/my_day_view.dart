import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/widgets/widgets.dart';

class MyDayView extends StatelessWidget {
  const MyDayView({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.features.home.myDay.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Gap(6),
            Text(
              DateFormat('EEEE, d MMMM').format(DateTime.now()),
              style: style.bodyLarge,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: _TasksBuilder(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(defaultPadding),
          child: ListTile(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const TaskAddModal(
                TaskAddConfig(listId: 1, isMyDay: true),
              ),
            ),
            leading: const Icon(IconsaxOutline.add),
            title: const Text('Add a task'),
          ),
        ),
      ),
    );
  }
}

class _TasksBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(myDayProvider);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.tasks.isEmpty) {
      return const EmptyTasksToday();
    }

    final notifier = ref.read(myDayProvider.notifier);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      itemCount: provider.tasks.length,
      itemBuilder: (_, i) {
        final Task task = provider.tasks[i];
        return TaskCard(
          onTap: () {
            ref.read(taskAccessTypeProvider.notifier).setToday();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TaskPage(task.id),
                fullscreenDialog: true,
              ),
            );
          },
          onDismissed: () {
            notifier.onDeleteTask(task.id);
          },
          onToggleCompleted: () {
            notifier.onToggleCompleted(task.id);
          },
          onToggleImportant: () {
            notifier.onToggleImportant(task.id);
          },
          task: task,
        );
      },
    );
  }
}
