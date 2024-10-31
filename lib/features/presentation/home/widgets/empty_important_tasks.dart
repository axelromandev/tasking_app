import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class EmptyImportantTasks extends ConsumerWidget {
  const EmptyImportantTasks({super.key});

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
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(8.0),
            Text(
              S.features.home.important.empty.subtitle,
              textAlign: TextAlign.center,
              style: style.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
