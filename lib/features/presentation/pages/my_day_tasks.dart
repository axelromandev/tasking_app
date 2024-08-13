import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';

class MyDayTasks extends ConsumerWidget {
  const MyDayTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: build tasks in my day

    return _EmptyTasks();
  }
}

class _EmptyTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
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
                BoxIcons.bx_sun,
                size: 38.0,
                color: colorPrimary,
              ),
            ),
            const Gap(defaultPadding),
            Text(
              'My Day is nice',
              style: style.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8.0),
            Text(
              "You don't have any tasks today.",
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
