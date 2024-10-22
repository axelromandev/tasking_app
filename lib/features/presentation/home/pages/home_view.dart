import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/i18n/i18n.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

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
      body: const EmptyTasksToday(),
    );
  }
}
