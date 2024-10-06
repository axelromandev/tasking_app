import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/pages/pages.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard(this.task, {super.key});

  final Task task;

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  late Key key;

  @override
  void initState() {
    key = Key('${widget.task.id}');
    super.initState();
  }

  void open() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TaskPage(widget.task),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(taskProvider(widget.task));
    final notifier = ref.read(taskProvider(widget.task).notifier);

    final bool isCompleted = (provider.completedAt != null);

    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              IconsaxOutline.trash,
              size: 18,
              color: Colors.white,
            ),
            const Gap(8.0),
            Text(S.common.buttons.delete, style: style.bodyLarge),
          ],
        ),
      ),
      onDismissed: (_) => notifier.onDeleteTask(),
      confirmDismiss: (_) async => await showDialog(
        context: context,
        builder: (_) => TaskDeleteDialog(),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: defaultPadding),
        visualDensity: VisualDensity.compact,
        iconColor: isCompleted ? Colors.white70 : Colors.white,
        shape: const RoundedRectangleBorder(),
        leading: IconButton(
          onPressed: notifier.onToggleCompleted,
          icon: Icon(
            isCompleted ? IconsaxOutline.record_circle : IconsaxOutline.record,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: GestureDetector(
          onTap: open,
          child: Text(
            provider.title,
            style: isCompleted
                ? style.bodyMedium?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                    color: Colors.grey,
                  )
                : style.bodyLarge,
          ),
        ),
        subtitle: ((widget.task.reminder != null) ||
                (widget.task.notes.isNotEmpty))
            ? GestureDetector(
                onTap: open,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.task.reminder != null)
                      Row(
                        children: [
                          const Icon(
                            IconsaxOutline.notification,
                            size: 12,
                          ),
                          const Gap(4.0),
                          Text(
                            HumanFormat.datetime(widget.task.reminder),
                            style: style.bodySmall,
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        const Icon(
                          IconsaxOutline.document,
                          size: 12,
                        ),
                        const Gap(4.0),
                        Text(
                          widget.task.notes,
                          style: isCompleted
                              ? style.bodySmall?.copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey,
                                )
                              : style.bodySmall?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
