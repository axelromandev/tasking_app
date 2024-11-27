import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/calendar/calendar.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/widgets/widgets.dart';

class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          CustomCalendar(
            selectedDate: provider.selectedDate ?? DateTime.now(),
            onSelectedDate: notifier.onSelectedDate,
            header: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(IconsaxOutline.calendar_1, color: colorPrimary),
                const Gap(12),
                Text(
                  S.features.calendar.title,
                  style:
                      style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          _TasksBuilder(),
        ],
      ),
    );
  }
}

class _TasksBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(calendarProvider);
    final notifier = ref.read(calendarProvider.notifier);

    if (provider.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.groups.isEmpty) {
      return _EmptyTasks();
    }

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: provider.groups.keys.map((listTitle) {
          final tasks = provider.groups[listTitle]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8, bottom: 8, top: 16),
                child: Text(listTitle, style: style.bodyLarge),
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, __) => const Gap(6),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    onTap: () {
                      ref.read(taskAccessTypeProvider.notifier).setCalendar();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TaskPage(task.id),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    onToggleCompleted: () => notifier.toggleCompleted(task),
                    onToggleImportant: () => notifier.toggleImportant(task),
                  );
                },
              ),
              const Gap(defaultPadding),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _EmptyTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconsaxOutline.task,
              color: colorPrimary,
              size: 32,
            ),
            const Gap(8),
            SizedBox(
              child: Text(
                'No hay tareas con fechas límite para hoy',
                textAlign: TextAlign.center,
                style: style.bodyLarge,
              ),
            ),
            const Gap(8),
            SizedBox(
              width: 300,
              child: Text(
                'Puedes ver todas tus tareas en las listas de tareas',
                textAlign: TextAlign.center,
                style: style.bodyLarge?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
