import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/presentation/pages/views/views.dart';
import 'package:tasking/presentation/providers/providers.dart';
import 'package:tasking/presentation/shared/shared.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);

    return Scaffold(
      body: [
        const HomeView(),
        const CalendarView(),
        const ListsView(),
        const SettingsView(),
      ][provider.currentIndex],
      bottomNavigationBar: _NavigatorBar(),
    );
  }
}

class _NavigatorBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final currentIndex = ref.watch(homeProvider).currentIndex;
    final notifier = ref.read(homeProvider.notifier);

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: defaultPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(0),
              iconSelected: BoxIcons.bxs_home,
              iconUnselected: BoxIcons.bx_home,
              isSelected: currentIndex == 0,
            ),
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(1),
              iconSelected: BoxIcons.bxs_calendar,
              iconUnselected: BoxIcons.bx_calendar,
              isSelected: currentIndex == 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  builder: (_) => const ListTasksAddModal(),
                ),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(defaultPadding),
                  backgroundColor: colorPrimary,
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(BoxIcons.bx_plus),
              ),
            ),
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(2),
              iconSelected: BoxIcons.bxs_folder,
              iconUnselected: BoxIcons.bx_folder,
              isSelected: currentIndex == 2,
            ),
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(3),
              iconSelected: BoxIcons.bxs_cog,
              iconUnselected: BoxIcons.bx_cog,
              isSelected: currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigatorBarItem extends ConsumerWidget {
  const _NavigatorBarItem({
    required this.onPressed,
    required this.iconSelected,
    required this.iconUnselected,
    required this.isSelected,
  });

  final VoidCallback onPressed;
  final IconData iconSelected;
  final IconData iconUnselected;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(defaultPadding),
        foregroundColor: isSelected ? colorPrimary : Colors.white,
      ),
      iconSize: 25,
      icon: Icon(isSelected ? iconSelected : iconUnselected),
    );
  }
}
