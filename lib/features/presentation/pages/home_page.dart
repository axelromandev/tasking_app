import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../modals/list_tasks_add_modal.dart';
import '../modals/list_tasks_options_modal.dart';
import '../modals/task_add_modal.dart';
import '../providers/list_tasks_provider.dart';
import '../views/build_all_list_tasks.dart';
import '../views/build_list_tasks.dart';
import '../widgets/menu_drawer.dart';

final keyScaffold = GlobalKey<ScaffoldState>();

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listTasksProvider);

    return Scaffold(
      key: keyScaffold,
      drawer: const Menu(),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (list == null)
              Text(
                'All Tasks',
                style: Theme.of(context).textTheme.titleLarge,
              ),
          ],
        ),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => keyScaffold.currentState?.openDrawer(),
          icon: Icon(
            BoxIcons.bx_menu_alt_left,
            color: ref.watch(colorThemeProvider),
          ),
        ),
        actions: [
          if (list != null) ...[
            IconButton(
              onPressed: ref.read(listTasksProvider.notifier).onPinned,
              color: ref.watch(colorThemeProvider),
              icon: Icon(
                list.isPinned ? BoxIcons.bxs_pin : BoxIcons.bx_pin,
                size: 18,
              ),
            ),
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (_) => const ListTasksOptionsModal(),
              ),
              color: ref.watch(colorThemeProvider),
              icon: const Icon(BoxIcons.bx_dots_horizontal_rounded),
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 1.5,
            color: Colors.white.withOpacity(.06),
          ),
          Expanded(
            child: (list == null)
                ? const BuildAllListTasks()
                : const BuildListTasks(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (list == null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => const ListTasksAddModal(),
            );
          } else {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: MyColors.cardDark,
              builder: (_) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const TaskAddModal(),
                ),
              ),
            );
          }
        },
        child: const Icon(BoxIcons.bx_plus),
      ),
    );
  }
}
