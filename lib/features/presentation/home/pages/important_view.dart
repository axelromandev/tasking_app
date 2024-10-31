import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ImportantView extends ConsumerWidget {
  const ImportantView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: ImportantView Implement build method.

    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(importantProvider);

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(IconsaxOutline.star, color: colorPrimary),
            const Gap(12),
            Text(
              S.features.home.important.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconsaxOutline.more),
          ),
        ],
      ),
      body: provider.tasks.isEmpty ? _EmptyTasks() : _TasksBuilder(),
    );
  }
}

class _TasksBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.read(importantProvider).tasks;

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      itemBuilder: (_, i) {
        final Task task = tasks[i];
        return TaskCard(
          task: task,
          onDismissed: () {},
          onToggleCompleted: () {},
          onToggleImportant: () {},
        );
      },
    );
  }
}

class _EmptyTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: colorPrimary.withOpacity(.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconsaxOutline.star,
                size: 38.0,
                color: colorPrimary,
              ),
            ),
            const Gap(defaultPadding),
            Text(
              S.features.home.important.empty.title,
              textAlign: TextAlign.center,
              style: style.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8.0),
            Text(
              S.features.home.important.empty.subtitle,
              textAlign: TextAlign.center,
              style: style.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
