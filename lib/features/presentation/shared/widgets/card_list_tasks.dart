import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasksCard extends ConsumerWidget {
  const ListTasksCard({
    required this.onTap,
    required this.list,
    this.isSelected = false,
    super.key,
  });

  final VoidCallback onTap;
  final ListTasks list;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    return ListTile(
      onTap: onTap,
      leading: Icon(list.icon, size: 20),
      iconColor: isSelected ? colorPrimary : null,
      textColor: isSelected ? colorPrimary : null,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      title: Text(list.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (list.pendingTasksLength > 0)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${list.pendingTasksLength}',
                style: style.bodySmall,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
