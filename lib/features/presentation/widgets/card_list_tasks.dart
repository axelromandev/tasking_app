import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
    final color = Color(list.color ?? 0xFF000000);
    final style = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        onTap: onTap,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          BoxIcons.bxs_circle,
          color: list.archived ? color.withOpacity(.4) : color,
          size: 18,
        ),
        title: Text(list.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (list.tasks.isNotEmpty)
              Text(
                '${list.tasks.length}',
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
