import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';

class EmptyTasksToday extends ConsumerWidget {
  const EmptyTasksToday({super.key});

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
