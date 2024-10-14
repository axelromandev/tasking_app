import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/i18n/i18n.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final getTodayTasksAsync = ref.read(homeProvider.notifier).getTodayTasks;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(IconsaxOutline.home_2, color: colorPrimary),
            const Gap(12),
            Text(
              S.pages.home.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMM d - EEEE').format(DateTime.now()),
              style: style.titleLarge?.copyWith(color: Colors.grey),
            ),
            // TODO: Implement build tasks list
            FutureBuilder(
              future: getTodayTasksAsync(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: style.bodyLarge,
                    ),
                  );
                }

                final tasks = snapshot.data!;

                if (tasks.isEmpty) {
                  return _EmptyTasksToday();
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return ListTile(
                        title: Text(task.title),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyTasksToday extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconsaxOutline.sun_1,
              color: colorPrimary,
              size: 42,
            ),
            const Gap(8),
            Text(
              '¡Disfruta tu día!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(8),
            Text(
              'No tienes tareas para hoy',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
