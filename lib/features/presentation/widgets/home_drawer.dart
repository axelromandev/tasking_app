import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/theme/color_theme.dart';
import '../../../generated/strings.g.dart';
import '../providers/home_provider.dart';

class HomeDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final pages = ref.watch(homeProvider.notifier).pages;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              leading: Icon(
                BoxIcons.bxs_crown,
                color: ref.watch(colorThemeProvider),
                size: 22,
              ),
              title: Text(S.commons.appName, style: style.titleLarge),
            ),
            const Gap(8.0),
            ...pages.map((page) {
              final index = pages.indexOf(page);
              return ListTile(
                onTap: () {
                  ref.read(homeProvider.notifier).onChangeIndex(index);
                  Navigator.pop(context);
                },
                selected: ref.watch(homeProvider) == index,
                selectedColor: ref.watch(colorThemeProvider),
                shape: const RoundedRectangleBorder(),
                visualDensity: VisualDensity.compact,
                leading: Icon(page.icon, size: 20),
                title: Text(page.title),
              );
            }),
          ],
        ),
      ),
    );
  }
}
