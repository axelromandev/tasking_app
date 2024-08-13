import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../config/config.dart';
import '../providers/home_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final currentIndex = ref.watch(homeProvider);
    final notifier = ref.watch(homeProvider.notifier);

    final pages = notifier.pages;

    return Scaffold(
      key: ref.read(homeScaffoldKeyProvider),
      appBar: AppBar(
        title: Text(pages[currentIndex].title, style: style.bodyLarge),
      ),
      body: Column(
        children: [
          Container(
            height: 1.5,
            color: Colors.white.withOpacity(.06),
          ),
          Expanded(child: pages[currentIndex].child),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: ref.read(colorThemeProvider),
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        currentIndex: currentIndex,
        onTap: notifier.onChangeIndex,
        items: pages.map((e) {
          return SalomonBottomBarItem(
            icon: Icon(e.icon),
            title: Text(e.title),
          );
        }).toList(),
      ),
    );
  }
}
