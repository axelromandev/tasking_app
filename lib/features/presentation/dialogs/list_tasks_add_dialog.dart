import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/const/constants.dart';
import '../providers/list_tasks_add_dialog_provider.dart';

class ListTasksAddDialog extends ConsumerWidget {
  const ListTasksAddDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final notifier = ref.read(listTasksAddDialogProvider.notifier);
    final provider = ref.watch(listTasksAddDialogProvider);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      left: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      'New list',
                      style: style.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextFormField(
                    cursorColor: provider.color,
                    onChanged: notifier.onNameChanged,
                    decoration: InputDecoration(
                      hintText: 'Enter list title',
                      hintStyle: style.bodyLarge?.copyWith(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: defaultPadding,
                      left: 8,
                      bottom: 8,
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Text('Color'),
                  ),
                  ColorPicker(
                    padding: const EdgeInsets.only(
                      bottom: defaultPadding,
                    ),
                    enableShadesSelection: false,
                    borderRadius: 20,
                    width: 36,
                    height: 36,
                    pickersEnabled: const <ColorPickerType, bool>{
                      ColorPickerType.wheel: false,
                      ColorPickerType.accent: false,
                      ColorPickerType.bw: false,
                      ColorPickerType.custom: false,
                      ColorPickerType.primary: true,
                    },
                    color: provider.color,
                    onColorChanged: notifier.onColorChanged,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white70,
                        ),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: provider.name.isEmpty
                            ? null
                            : () => notifier.onSubmit(context),
                        style: TextButton.styleFrom(
                          foregroundColor: provider.color,
                        ),
                        child: const Text('Create List'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
