import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../domain/domain.dart';
import '../modals/add_list_tasks_modal.dart';
import '../providers/list_tasks_provider.dart';
import '../providers/select_list_id_provider.dart';
import '../providers/show_list_tasks_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/list_tasks_card.dart';
import '../widgets/widgets.dart';

final keyScaffold = GlobalKey<ScaffoldState>();

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final listId = ref.watch(selectListIdProvider);

    return Scaffold(
      key: keyScaffold,
      drawer: const Menu(),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => keyScaffold.currentState?.openDrawer(),
          icon: Icon(BoxIcons.bx_menu_alt_left, color: colors.primary),
        ),
        title: Text(listId == 0 ? 'ALL' : '', style: style.bodyLarge),
        centerTitle: true,
        actions: [
          if (listId == 0)
            IconButton(
              onPressed: () {},
              icon: Icon(BoxIcons.bx_cloud, color: colors.primary, size: 18),
            ),
          if (listId != 0) ...[
            IconButton(
              onPressed: () {},
              icon: Icon(BoxIcons.bx_pin, color: colors.primary, size: 18),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(BoxIcons.bx_dots_horizontal_rounded,
                  color: colors.primary),
            ),
          ],
        ],
      ),
      body: listId == 0 ? _BuildAllListTasks() : _BuildListTasks(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (listId == 0) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => const AddListTasksModal(),
            );
          } else {
            print('add task');
          }
        },
        child: const Icon(BoxIcons.bx_plus),
      ),
    );
  }
}

class _BuildAllListTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(showListTasksProvider);

    if (lists.isEmpty) {
      return _EmptyListTasks();
    }

    final pinnedLists = lists.where((list) => list.isPinned).toList();
    final unpinnedLists = lists.where((list) => !list.isPinned).toList();

    final style = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: 1.5,
          color: Colors.white.withOpacity(.06),
        ),
        if (pinnedLists.isNotEmpty) ...[
          ListTile(
            visualDensity: VisualDensity.compact,
            leading: const Icon(
              BoxIcons.bxs_pin,
              size: 16,
              color: Colors.white38,
            ),
            minLeadingWidth: 0,
            title: Text('Pinned',
                style: style.bodySmall?.copyWith(
                  color: Colors.white38,
                )),
          ),
          MasonryGridView.count(
            itemCount: pinnedLists.length,
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final list = pinnedLists[index];
              return ListTasksCard(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  ref.read(selectListIdProvider.notifier).change(list.id);
                },
                list: list,
              );
            },
          ),
          const Gap(defaultPadding),
          if (unpinnedLists.isNotEmpty)
            Container(
              height: 1.5,
              color: Colors.white.withOpacity(.06),
            ),
        ],
        MasonryGridView.count(
          itemCount: unpinnedLists.length,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(defaultPadding),
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final list = unpinnedLists[index];
            return ListTasksCard(
              onTap: () {
                HapticFeedback.mediumImpact();
                ref.read(selectListIdProvider.notifier).change(list.id);
              },
              list: list,
            );
          },
        ),
      ],
    );
  }
}

class _BuildListTasks extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listId = ref.watch(selectListIdProvider);
    final listTasks = ref.watch(listTasksProvider(listId));

    if (listTasks == null) {
      return const SizedBox();
    }

    final style = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          height: 1.5,
          color: Colors.white.withOpacity(.06),
        ),
        ListTile(
          onTap: () {
            print('tap title');
          },
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          leading: Icon(
            listTasks.icon?.iconData ?? BoxIcons.bxs_circle,
            color: Color(listTasks.color ?? 0xFF000000),
            size: 18,
          ),
          title: Text(listTasks.name, style: style.bodyLarge),
        ),
        listTasks.tasks.isEmpty
            ? _EmptyTasks()
            : _BuildTasks(listTasks.tasks.toList()),
      ],
    );
  }
}

class _BuildTasks extends StatelessWidget {
  const _BuildTasks(this.tasks);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final pendingTasks = tasks.where((task) => !task.completed).toList();
    pendingTasks.sort((a, b) => a.position.compareTo(b.position));

    final completedTasks = tasks.where((task) => task.completed).toList();
    completedTasks.sort((a, b) => a.position.compareTo(b.position));

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: pendingTasks.length,
            itemBuilder: (context, index) {
              final task = pendingTasks[index];
              return TaskCard(task);
            },
          ),
          if (pendingTasks.isNotEmpty && completedTasks.isNotEmpty) ...[
            const Gap(defaultPadding),
            const Divider(height: 0),
            ListTile(
              visualDensity: VisualDensity.compact,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              title: Text(
                'Completed',
                style: style.bodySmall?.copyWith(color: Colors.white70),
              ),
            ),
          ],
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];
              return TaskCard(task);
            },
          ),
        ],
      ),
    );
  }
}

class _EmptyListTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Container(
          height: 1.5,
          color: Colors.white.withOpacity(.06),
        ),
        Container(
          margin: const EdgeInsets.only(top: 200.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  BoxIcons.bxs_inbox,
                  size: 38.0,
                  color: colors.primary,
                ),
              ),
              const Gap(defaultPadding),
              Text('There is no list.',
                  style: style.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
              const Gap(8.0),
              Text('Press + to add the list',
                  style: style.bodyMedium?.copyWith(
                    color: Colors.white70,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 200.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              BoxIcons.bx_task,
              size: 38.0,
              color: Colors.white70,
            ),
          ),
          const Gap(defaultPadding),
          Text('There is no task.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          const Gap(8.0),
          Text('Press + to add the task',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  )),
        ],
      ),
    );
  }
}
