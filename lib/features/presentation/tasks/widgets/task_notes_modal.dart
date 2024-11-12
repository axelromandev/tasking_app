import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskNotesModal extends ConsumerStatefulWidget {
  const TaskNotesModal({this.value, super.key});

  final String? value;

  @override
  ConsumerState<TaskNotesModal> createState() => _TaskNotesModalState();
}

class _TaskNotesModalState extends ConsumerState<TaskNotesModal> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              controller: controller,
              maxLength: 255,
              maxLines: 4,
              cursorColor: colorPrimary,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                filled: false,
                border: InputBorder.none,
                labelText: S.features.tasks.addModal.notes,
                labelStyle: const TextStyle(color: Colors.grey),
                helperStyle: const TextStyle(color: Colors.grey),
                helper: TextButton(
                  onPressed: controller.text.isNotEmpty
                      ? () => Navigator.pop(context, '')
                      : null,
                  child: Text(S.common.buttons.clear),
                ),
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (value) {
                Navigator.pop(context, value);
              },
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
