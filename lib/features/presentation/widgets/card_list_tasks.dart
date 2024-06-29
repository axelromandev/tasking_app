import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../app.dart';

class ListTasksCard extends StatelessWidget {
  const ListTasksCard({
    required this.onTap,
    required this.list,
    super.key,
  });

  final VoidCallback onTap;
  final ListTasks list;

  @override
  Widget build(BuildContext context) {
    const int maxLength = 5;

    final tasks = list.tasks.where((task) => !task.completed).toList();

    final List<Task> tasksLimit = tasks.length > maxLength
        ? tasks.take(maxLength).toList()
        : tasks.toList();

    final int tasksHideLength = tasks.length - maxLength;

    final color = Color(list.color ?? 0xFF000000);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(list.color ?? 0xFF000000).withOpacity(.02),
          border: Border.all(
            color: list.archived ? color.withOpacity(.4) : color,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: defaultPadding,
                left: defaultPadding,
                right: defaultPadding,
              ),
              child: Row(
                children: [
                  Icon(
                    BoxIcons.bxs_circle,
                    color: list.archived ? color.withOpacity(.8) : color,
                    size: 18,
                  ),
                  const Gap(defaultPadding),
                  Flexible(child: Text(list.title)),
                ],
              ),
            ),
            if (tasksLimit.isNotEmpty) const Gap(8.0),
            for (final task in tasksLimit)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      task.completed ? BoxIcons.bx_check : BoxIcons.bx_circle,
                      size: 18,
                      color: Colors.white70,
                    ),
                    const Gap(defaultPadding),
                    SizedBox(
                      width: 100,
                      child: Text(
                        task.title,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            if (tasks.length > maxLength)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    Text(
                      '+$tasksHideLength',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const Gap(defaultPadding),
                    const Text(
                      'Tasks',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
