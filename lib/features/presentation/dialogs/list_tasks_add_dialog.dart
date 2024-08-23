import 'dart:ui';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/dialogs/dialogs.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/i18n/generated/translations.g.dart';

class ListTasksAddDialog extends ConsumerWidget {
  const ListTasksAddDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final notifier = ref.read(listTasksAddDialogProvider.notifier);
    final provider = ref.watch(listTasksAddDialogProvider);

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  bottom: defaultPadding,
                ),
                child: Text(
                  S.common.dialogs.listTasksAdd.title,
                  style: style.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => showDialog<Color?>(
                      context: context,
                      builder: (_) => ColorPickerDialog(
                        color: provider.color,
                      ),
                    ).then((color) {
                      if (color != null) {
                        notifier.onColorChanged(color);
                      }
                    }),
                    child: ColorIndicator(
                      width: 30,
                      height: 30,
                      borderRadius: 30,
                      color: provider.color,
                    ),
                  ),
                  const Gap(defaultPadding / 2),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: provider.color,
                      onChanged: notifier.onNameChanged,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: S.common.dialogs.listTasksAdd.placeholder,
                        hintStyle: style.bodyLarge?.copyWith(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(defaultPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    child: Text(S.common.buttons.cancel),
                  ),
                  TextButton(
                    onPressed: provider.name.isEmpty
                        ? null
                        : () => notifier.onSubmit(context),
                    style: TextButton.styleFrom(
                      foregroundColor: provider.color,
                    ),
                    child: Text(S.common.dialogs.listTasksAdd.button),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
