import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/domain/domain.dart';

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
    final style = Theme.of(context).textTheme;

    final pendingTasks = list.tasks.where((task) => !task.completed).toList();

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          BoxIcons.bxs_circle,
          color: list.archived ? list.color.withOpacity(.4) : list.color,
          size: 18,
        ),
        title: Text(list.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pendingTasks.isNotEmpty)
              Text(
                '${pendingTasks.length}',
                style: style.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
