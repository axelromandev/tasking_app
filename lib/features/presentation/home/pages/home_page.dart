import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/shared/shared.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return Scaffold(
      key: notifier.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            notifier.scaffoldKey.currentState?.openDrawer();
          },
          color: colorPrimary,
          icon: const Icon(IconsaxOutline.menu),
        ),
      ),
      body: provider.body ?? const MyDayView(),
      resizeToAvoidBottomInset: false,
      drawer: _Drawer(),
    );
  }
}

class _Drawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final typeView = ref.watch(homeProvider).typeView;
    final notifier = ref.read(homeProvider.notifier);

    // SLANG: Drawer Home labels

    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Gap(defaultPadding),
                Icon(
                  IconsaxBold.crown_1,
                  color: colorPrimary,
                  size: 30,
                ),
                const Gap(8),
                Text(
                  'Tasking',
                  style: style.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(8),
                Text(
                  'Beta',
                  style: style.bodySmall?.copyWith(
                    color: colorPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => context.push('/search'),
                  icon: const Icon(IconsaxOutline.search_normal),
                ),
                const Gap(8),
              ],
            ),
            const Gap(8),
            _DrawerItem(
              icon: IconsaxOutline.sun_1,
              title: 'My Day',
              isSelected: typeView == TypeView.home,
              onTap: () {
                notifier.onChangeView(TypeView.home);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.star,
              title: 'Important',
              isSelected: typeView == TypeView.important,
              onTap: () {
                notifier.onChangeView(TypeView.important);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.calendar_1,
              title: 'Calendar',
              isSelected: typeView == TypeView.calendar,
              onTap: () {
                notifier.onChangeView(TypeView.calendar);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.home_2,
              title: 'All Tasks',
              isSelected: typeView == TypeView.tasks,
              onTap: () {
                notifier.onChangeView(TypeView.tasks);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(IconsaxOutline.add),
              trailing: const Icon(IconsaxOutline.arrow_right_3, size: 16),
              title: const Text('New list'),
              contentPadding: const EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ListTasksAddPage()),
              ),
            ),
            _ListsBuilder(),
            const Divider(height: 0),
            _DrawerItem(
              icon: IconsaxOutline.setting,
              title: 'Settings',
              onTap: () => context.push('/settings'),
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}

class _ListsBuilder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listId = ref.watch(homeProvider).listId;
    final notifier = ref.read(homeProvider.notifier);

    final provider = ref.watch(listsProvider);

    if (provider.isLoading) {
      return Container();
    }

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: provider.lists.length,
        padding: EdgeInsets.zero,
        itemBuilder: (_, i) {
          final list = provider.lists[i];
          return ListTasksCard(
            onTap: () => notifier.onListSelected(list.id),
            isSelected: (listId ?? -1) == list.id,
            list: list,
          );
        },
      ),
    );
  }
}

class _DrawerItem extends ConsumerWidget {
  const _DrawerItem({
    required this.onTap,
    required this.title,
    required this.icon,
    this.isSelected = false,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return ListTile(
      leading: Icon(icon),
      iconColor: isSelected ? colorPrimary : null,
      textColor: isSelected ? colorPrimary : null,
      title: Text(title),
      onTap: onTap,
    );
  }
}
