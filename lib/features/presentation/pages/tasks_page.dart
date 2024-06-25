import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../modals/list_tasks_add_modal.dart';
import '../modals/task_add_modal.dart';
import '../providers/list_tasks_provider.dart';
import '../views/build_all_list_tasks.dart';
import '../views/build_list_tasks.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(listTasksProvider);
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
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
        backgroundColor: colorPrimary,
        onPressed: () {
          if (list == null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const ListTasksAddModal(),
            );
          } else {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.card,
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
