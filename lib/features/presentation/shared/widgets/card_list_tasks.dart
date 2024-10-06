import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasksCard extends ConsumerWidget {
  const ListTasksCard({
    required this.onTap,
    required this.list,
    super.key,
  });

  final VoidCallback onTap;
  final ListTasks list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final pendingTasks =
        list.tasks.where((task) => task.completedAt == null).toList();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          visualDensity: VisualDensity.compact,
          leading: Icon(list.icon, color: colorPrimary, size: 20),
          minLeadingWidth: 0,
          title: Text(list.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pendingTasks.isNotEmpty)
                Text(
                  '${pendingTasks.length} Pendientes',
                  style: style.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
