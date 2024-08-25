import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/presentation/providers/providers.dart';
import 'package:tasking/presentation/shared/shared.dart';

class ListTasksAddModal extends ConsumerWidget {
  const ListTasksAddModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(listTasksAddDialogProvider);
    final notifier = ref.read(listTasksAddDialogProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: provider.color,
                ),
                child: Text(S.common.buttons.cancel),
              ),
              Text(
                S.common.modals.listTasksAdd.title,
                style: style.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomFilledButton(
                onPressed: provider.name.isEmpty
                    ? null
                    : () => notifier.onSubmit(context),
                backgroundColor: provider.color,
                child: Text(S.common.buttons.add),
              ),
            ],
          ),
          const Gap(defaultPadding),
          TextFormField(
            autofocus: true,
            cursorColor: provider.color,
            onChanged: notifier.onNameChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.common.modals.listTasksAdd.placeholder,
              hintStyle: style.bodyLarge?.copyWith(
                color: Colors.white54,
              ),
            ),
          ),
          const Gap(defaultPadding),
          Card(
            margin: EdgeInsets.zero,
            child: ColorPicker(
              title: const Text('Selecciona un color'),
              borderRadius: 20,
              enableShadesSelection: false,
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
          ),
        ],
      ),
    );
  }
}
