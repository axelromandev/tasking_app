import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/home/providers/my_day_provider.dart';
import 'package:tasking/features/presentation/shared/shared.dart';

class MyDayView extends ConsumerWidget {
  const MyDayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    // SLANG: Translate the labels

    final provider = ref.watch(myDayProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Day',
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
      body: (provider.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : _TasksBuilder(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(defaultPadding),
          child: ListTile(
            onTap: () {},
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
    final tasks = ref.watch(myDayProvider).tasks;

    if (tasks.isEmpty) {
      return const EmptyTasksToday();
    }

    final notifier = ref.read(myDayProvider.notifier);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      itemBuilder: (_, i) {
        final Task task = tasks[i];
        return TaskCard(
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
