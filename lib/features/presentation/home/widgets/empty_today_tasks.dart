import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class EmptyTasksToday extends ConsumerWidget {
  const EmptyTasksToday({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Center(
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
            S.features.home.myDay.empty.title,
            style: style.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(8),
          Text(
            S.features.home.myDay.empty.subtitle,
            style: style.bodyLarge,
          ),
        ],
      ),
    );
  }
}
