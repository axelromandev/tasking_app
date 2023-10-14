import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';

import '../../../generated/l10n.dart';

class TaskDetails extends ConsumerStatefulWidget {
  final Task task;
  const TaskDetails(this.task, {super.key});

  @override
  ConsumerState<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends ConsumerState<TaskDetails> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    ref.read(taskDetailsProvider.notifier).initialize(widget.task);
    controller = TextEditingController(text: widget.task.message);
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskDetailsProvider);

    if (task == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    if (value.toLowerCase() == task.message.toLowerCase()) {
                      focusNode.unfocus();
                      return;
                    }

                    if (value.isEmpty) {
                      controller.text = task.message;
                      focusNode.unfocus();
                      return;
                    }

                    // save changes
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: null,
                  decoration: InputDecoration(
                    filled: focusNode.hasFocus,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: IconButton(
                        onPressed: () {
                          //TODO: save changes to task
                        },
                        icon: task.isCompleted
                            ? const Icon(BoxIcons.bx_check_circle,
                                color: Colors.white)
                            : const Icon(BoxIcons.bx_circle,
                                color: Colors.white),
                      ),
                    ),
                    suffixIcon: focusNode.hasFocus
                        ? IconButton(
                            onPressed: () => controller.clear(),
                            icon: const Icon(HeroIcons.x_mark),
                          )
                        : const Icon(
                            BoxIcons.bx_pencil,
                            size: 18,
                            color: Colors.white,
                          ),
                    hintText: S.of(context).home_button_add,
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    onTap: () {
                      //TODO: add due date to task
                      ref
                          .read(taskDetailsProvider.notifier)
                          .onAddDueDate(context);
                    },
                    leading: const Icon(HeroIcons.calendar),
                    title: Text(
                      task.dueDate != null
                          ? task.dueDate.toString()
                          : S.of(context).button_add_due_date,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    onTap: () {
                      //TODO: add reminder to task

                      ref
                          .read(taskDetailsProvider.notifier)
                          .onAddReminder(context);
                    },
                    leading:
                        const Icon(HeroIcons.bell_alert, color: Colors.white),
                    title: Text(
                      task.dueDate != null
                          ? task.dueDate.toString()
                          : S.of(context).button_reminder,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                CustomFilledButton(
                  margin: const EdgeInsets.only(top: 16),
                  onPressed: ref.read(taskDetailsProvider.notifier).onDelete,
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red.shade900.withOpacity(.1),
                  icon: const Icon(HeroIcons.trash, size: 16),
                  child: Text(S.of(context).button_delete_task),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
