import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/presentation/tasks/tasks.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskAddModal extends ConsumerWidget {
  const TaskAddModal(this.config, {super.key});

  final TaskAddConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(taskAddModalProvider(config));
    final notifier = ref.read(taskAddModalProvider(config).notifier);

    return SingleChildScrollView(
      child: Container(
        color: AppColors.background,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              maxLines: null,
              cursorColor: colorPrimary,
              onChanged: notifier.onNameChanged,
              controller: notifier.controller,
              focusNode: notifier.focusNode,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
              ],
              style: const TextStyle(fontSize: 16),
              onFieldSubmitted: (value) {
                notifier.onSubmit();
                notifier.focusNode.requestFocus();
              },
              decoration: InputDecoration(
                filled: false,
                hintText: S.features.tasks.addModal.placeholder,
                prefixIcon: const Icon(
                  IconsaxOutline.record,
                  color: Colors.white54,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  TextButton.icon(
                    onPressed: notifier.config.isMyDay
                        ? () {}
                        : () => notifier.openDatelineModal(context),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      overlayColor: Colors.transparent,
                      foregroundColor: (provider.dateline != null)
                          ? notifier.config.isMyDay
                              ? colorPrimary.withOpacity(0.8)
                              : colorPrimary
                          : Colors.white,
                    ),
                    icon: const Icon(IconsaxOutline.calendar_1, size: 20),
                    label: (provider.dateline != null)
                        ? Text(HumanFormat.datetime(provider.dateline))
                        : Text(S.features.tasks.addModal.dateline),
                  ),
                  TextButton.icon(
                    onPressed: () => notifier.openReminderModal(context),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      overlayColor: Colors.transparent,
                      foregroundColor: (provider.reminder != null)
                          ? colorPrimary
                          : Colors.white,
                    ),
                    icon: const Icon(IconsaxOutline.notification, size: 20),
                    label: Text(S.features.tasks.addModal.reminder),
                  ),
                  TextButton.icon(
                    onPressed: () => notifier.openNotesModal(context),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      overlayColor: Colors.transparent,
                      foregroundColor: (provider.notes.isNotEmpty)
                          ? colorPrimary
                          : Colors.white,
                    ),
                    icon: const Icon(IconsaxOutline.note_1, size: 20),
                    label: Text(S.features.tasks.addModal.notes),
                  ),
                ],
              ),
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
