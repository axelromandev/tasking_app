import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/domain/domain.dart';
import 'package:tasking/i18n/generated/translations.g.dart';
import 'package:tasking/presentation/dialogs/dialogs.dart';
import 'package:tasking/presentation/pages/pages.dart';
import 'package:tasking/presentation/providers/providers.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard(this.task, {super.key});

  final Task task;

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  late Key key;
  SharedPrefs prefs = SharedPrefs();

  @override
  void initState() {
    key = Key('${widget.task.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(taskProvider(widget.task));
    final notifier = ref.read(taskProvider(widget.task).notifier);

    final bool isCompleted = provider.completed;

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
              BoxIcons.bx_trash,
              size: 18,
              color: Colors.white,
            ),
            const Gap(8.0),
            Text(S.common.buttons.delete, style: style.bodyLarge),
          ],
        ),
      ),
      onDismissed: (_) => notifier.onDeleteTask(),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (_) => TaskDeleteDialog(),
        );
      },
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskPage(widget.task),
            fullscreenDialog: true,
          ),
        ),
        visualDensity: VisualDensity.compact,
        iconColor: isCompleted ? Colors.white70 : Colors.white,
        shape: const RoundedRectangleBorder(),
        leading: GestureDetector(
          onTap: notifier.onToggleCompleted,
          child: Icon(
            isCompleted ? BoxIcons.bxs_check_circle : BoxIcons.bx_circle,
            color: isCompleted ? Colors.white38 : null,
            size: 18,
          ),
        ),
        title: Text(
          provider.title,
          style: isCompleted
              ? style.bodyMedium?.copyWith(color: Colors.white70)
              : style.bodyLarge,
        ),
        subtitle: ((widget.task.reminder != null) ||
                (widget.task.note.isNotEmpty))
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.task.reminder != null)
                    Row(
                      children: [
                        const Icon(BoxIcons.bx_bell, size: 12),
                        const Gap(4.0),
                        Text(
                          HumanFormat.datetime(widget.task.reminder),
                          style: style.bodySmall,
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Icon(
                        BoxIcons.bx_file,
                        size: 12,
                        color: isCompleted ? Colors.white70 : Colors.white,
                      ),
                      const Gap(4.0),
                      Text(
                        widget.task.note,
                        style: style.bodySmall?.copyWith(
                          color: isCompleted ? Colors.white70 : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
