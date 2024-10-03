import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: HomeView Implement build method.
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.logo,
              width: 18,
              theme: SvgTheme(currentColor: colorPrimary),
            ),
            const Gap(12),
            Text(
              S.pages.home.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Gap(8),
            Text(
              'beta',
              style: style.bodyMedium?.copyWith(color: colorPrimary),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: const Center(child: Text('HomeView')),
    );
  }
}
