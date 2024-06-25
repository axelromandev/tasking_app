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
    final length = list.tasks.length;

    const int maxLength = 5;

    final List<Task> tasksLimit = length > maxLength
        ? list.tasks.take(maxLength).toList()
        : list.tasks.toList();

    final int tasksHideLength = length - maxLength;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(list.color ?? 0xFF000000).withOpacity(.02),
          border: Border.all(
            color: Color(list.color ?? 0xFF000000),
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
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  Icon(
                    list.icon?.iconData ?? BoxIcons.bxs_circle,
                    color: Color(list.color ?? 0xFF000000),
                    size: 18,
                  ),
                  const Gap(defaultPadding),
                  Flexible(child: Text(list.name)),
                ],
              ),
            ),
            for (final task in tasksLimit)
              Container(
                margin: const EdgeInsets.symmetric(
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
                        task.message,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            if (length > maxLength)
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
