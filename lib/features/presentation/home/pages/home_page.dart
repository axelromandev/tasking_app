import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/calendar/calendar.dart';
import 'package:tasking/features/presentation/home/home.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/widgets/widgets.dart';

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
      body: switch (provider.typeView) {
        TypeView.important => const ImportantView(),
        TypeView.calendar => const CalendarView(),
        TypeView.tasks => const ListTasksView(1),
        TypeView.lists => ListTasksView(provider.listId!),
        (_) => const MyDayView(),
      },
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
              title: S.features.home.myDay.title,
              isSelected: typeView == TypeView.home,
              tasksLength: ref.watch(myDayProvider).tasks.length,
              onTap: () {
                notifier.onChangeView(TypeView.home);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.star,
              title: S.features.home.important.title,
              isSelected: typeView == TypeView.important,
              tasksLength: ref.watch(importantProvider).tasks.length,
              onTap: () {
                notifier.onChangeView(TypeView.important);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.calendar_1,
              title: S.features.calendar.title,
              isSelected: typeView == TypeView.calendar,
              onTap: () {
                notifier.onChangeView(TypeView.calendar);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _DrawerItem(
              icon: IconsaxOutline.clipboard_tick,
              title: S.features.tasks.title,
              isSelected: typeView == TypeView.tasks,
              tasksLength: ref.watch(listTasksProvider(1)).pending.length,
              onTap: () {
                notifier.onChangeView(TypeView.tasks);
                notifier.scaffoldKey.currentState?.closeDrawer();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(IconsaxOutline.add),
              trailing: const Icon(IconsaxOutline.arrow_right_3, size: 16),
              title: Text(S.features.lists.page.addButton),
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
              title: S.features.settings.title,
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
    this.tasksLength = 0,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final bool isSelected;
  final int tasksLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return ListTile(
      leading: Icon(icon),
      iconColor: isSelected ? colorPrimary : null,
      textColor: isSelected ? colorPrimary : null,
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      trailing: (tasksLength > 0)
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Text('$tasksLength', style: style.bodySmall),
            )
          : null,
    );
  }
}
