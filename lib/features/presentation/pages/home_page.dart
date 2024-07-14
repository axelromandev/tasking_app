import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../providers/home_provider.dart';
import '../widgets/home_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final currentIndex = ref.watch(homeProvider);
    final pages = ref.watch(homeProvider.notifier).pages;

    return Scaffold(
      key: ref.read(homeScaffoldKeyProvider),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(homeScaffoldKeyProvider).currentState!.openDrawer();
              },
              child: Icon(
                BoxIcons.bx_menu_alt_left,
                color: ref.watch(colorThemeProvider),
              ),
            ),
            const Gap(16.0),
            Text(
              pages[currentIndex].title,
              style: style.bodyLarge,
            ),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      drawer: HomeDrawer(),
      body: pages[currentIndex].child,
    );
  }
}
