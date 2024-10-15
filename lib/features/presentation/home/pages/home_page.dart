import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/calendar/calendar.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/settings/settings.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);

    return Scaffold(
      body: [
        const HomeView(),
        const ListsView(),
        const CalendarView(),
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
              iconSelected: IconsaxBold.home_2,
              iconUnselected: IconsaxOutline.home_2,
              isSelected: currentIndex == 0,
            ),
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(1),
              iconSelected: IconsaxBold.folder_2,
              iconUnselected: IconsaxOutline.folder_2,
              isSelected: currentIndex == 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(defaultPadding),
                  backgroundColor: colorPrimary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                ),
                icon: const Icon(IconsaxOutline.add),
              ),
            ),
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(2),
              iconSelected: IconsaxBold.calendar,
              iconUnselected: IconsaxOutline.calendar_1,
              isSelected: currentIndex == 2,
            ),
            _NavigatorBarItem(
              onPressed: () => notifier.onChangeView(3),
              iconSelected: IconsaxBold.setting,
              iconUnselected: IconsaxOutline.setting,
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
