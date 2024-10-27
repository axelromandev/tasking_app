import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/calendar/calendar.dart';
import 'package:tasking/i18n/i18n.dart';

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
                  S.pages.calendar.title,
                  style:
                      style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (provider.tasksDay.isEmpty)
            _EmptyTasks()
          else
            // TODO: CalendarView Implement build tasks list
            Expanded(
              child: ListView.builder(
                itemCount: provider.tasksDay.length,
                itemBuilder: (context, index) {
                  final task = provider.tasksDay[index];
                  return ListTile(
                    title: Text(task.title),
                  );
                },
              ),
            ),
        ],
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
