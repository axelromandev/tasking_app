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
    final provider = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return Scaffold(
      key: notifier.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            notifier.scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(IconsaxOutline.menu),
        ),
      ),
      body: provider.body ?? const HomeView(),
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

    // TODO: SLANG - Drawer Home

    return Drawer(
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
              ],
            ),
            const Gap(8),
            // TODO: Make search task bar functional
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    IconsaxOutline.search_normal,
                    size: 16,
                  ),
                ),
              ),
            ),
            _DrawerItem(
              icon: IconsaxOutline.sun_1,
              title: 'My Day',
              isSelected: typeView == TypeView.home,
              onTap: () {
                notifier.onChangeView(TypeView.home);
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.star,
              title: 'Important',
              isSelected: typeView == TypeView.important,
              onTap: () {
                notifier.onChangeView(TypeView.important);
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.calendar_1,
              title: 'Calendar',
              isSelected: typeView == TypeView.calendar,
              onTap: () {
                notifier.onChangeView(TypeView.calendar);
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.home_2,
              title: 'Tasks',
              isSelected: typeView == TypeView.tasks,
              onTap: () {
                notifier.onChangeView(TypeView.tasks);
              },
            ),
            const Divider(),
            _ListsBuilder(),
            _DrawerItem(
              icon: IconsaxOutline.add,
              title: 'New list',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ListTasksAddPage()),
                );
              },
            ),
            const Spacer(),
            const Divider(),
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
    final provider = ref.watch(listsProvider);

    if (provider.isLoading) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: provider.lists.length,
      itemBuilder: (_, i) {
        final list = provider.lists[i];
        return ListTasksCard(
          onTap: () {
            // TODO: Render dynamic list tasks in the home page
          },
          list: list,
        );
      },
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
      shape: const RoundedRectangleBorder(),
      iconColor: isSelected ? colorPrimary : null,
      textColor: isSelected ? colorPrimary : null,
      title: Text(title),
      onTap: onTap,
    );
  }
}
