import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class TutorialPage extends ConsumerWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: StartTutorialPage Implement build method.

    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(IconsaxOutline.info_circle, color: colorPrimary),
            const Gap(12),
            Flexible(
              child: Text(
                S.features.intro.tutorial.title,
                style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        children: const [
          Center(child: Text('Step 1')),
          Center(child: Text('Step 2')),
        ],
      ),
    );
  }
}
